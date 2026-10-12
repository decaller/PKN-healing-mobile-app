// ============================================================================
// PKN HEALING FLUTTER CLIENT - LIBSQL VECTOR & HYBRID SEARCH SERVICE
// Membaca knowledge.db dengan LibSQL Vector Search (DiskANN) + FTS5 BM25
// 100% Offline-First di Perangkat Fisik (Zero Cloud Leak)
// ============================================================================

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Representasi artikel hasil pencarian
class SearchResultItem {
  final String id;
  final String title;
  final String category;
  final String contentType;
  final String provenance; // 'expert_verified' (Pakar) atau 'ai_assisted' (Wiki-AI)
  final String? author;
  final String summary;
  final String? snippet;
  final double? score; // Similarity score (Vector) atau RRF score (Hybrid)

  SearchResultItem({
    required this.id,
    required this.title,
    required this.category,
    required this.contentType,
    required this.provenance,
    this.author,
    required this.summary,
    this.snippet,
    this.score,
  });

  bool get isExpertVerified => provenance == 'expert_verified';

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'category': category,
    'content_type': contentType,
    'provenance': provenance,
    'author': author,
    'summary': summary,
    'snippet': snippet,
    'score': score,
  };
}

/// Interface driver LibSQL (kompatibel dengan libsql_dart / flutter_libsql / ffi)
abstract class LibsqlDatabaseClient {
  Future<List<Map<String, dynamic>>> query(String sql, [List<dynamic>? params]);
  Future<void> execute(String sql, [List<dynamic>? params]);
  Future<void> close();
}

/// Service Pencarian Vektor & Hybrid PKN Knowledge Base
class LibsqlVectorSearchService {
  LibsqlDatabaseClient? _dbClient;
  bool _isVectorIndexReady = false;

  /// Inisialisasi koneksi LibSQL ke knowledge.db (Read-Only)
  Future<void> initialize({
    required LibsqlDatabaseClient dbClient,
  }) async {
    _dbClient = dbClient;

    // Cek ketersediaan indeks vektor DiskANN di LibSQL
    try {
      final rows = await _dbClient!.query(
        "SELECT name FROM sqlite_master WHERE type='index' AND name='chunks_vector_idx'",
      );
      _isVectorIndexReady = rows.isNotEmpty;
    } catch (_) {
      _isVectorIndexReady = false;
    }
  }

  /// 1. Pencarian Semantik Vektor (LibSQL Vector Top-K)
  /// Menggunakan query embedding Float32List(384) yang dihasilkan secara on-device (ONNX)
  Future<List<SearchResultItem>> searchSemantic({
    required Float32List queryEmbedding,
    String provenance = 'all', // 'all', 'expert_verified', 'ai_assisted'
    String contentType = 'all', // 'all', 'article', 'doa', 'cerita_rpg', 'buku', 'event'
    int limit = 5,
  }) async {
    if (_dbClient == null) throw StateError('Service belum diinisialisasi');
    if (queryEmbedding.length != 384) {
      throw ArgumentError('Dimensi query vector harus 384, didapat ${queryEmbedding.length}');
    }

    // LibSQL menerima format vector32 dalam bentuk JSON array string: "[0.012, -0.045, ...]"
    final vectorJsonStr = jsonEncode(queryEmbedding.toList());

    List<Map<String, dynamic>> rows;

    if (_isVectorIndexReady) {
      // Menggunakan Virtual Table vector_top_k (DiskANN Index di LibSQL)
      var sql = '''
        SELECT 
          c.article_id AS id,
          a.title,
          a.category,
          a.content_type,
          a.provenance,
          a.author_or_speaker AS author,
          a.summary,
          c.chunk_content AS snippet,
          v.distance
        FROM vector_top_k('chunks_vector_idx', vector32(?), ?) AS v
        JOIN article_chunks AS c ON c.rowid = v.id
        JOIN articles AS a ON a.id = c.article_id
      ''';
      final params = <dynamic>[vectorJsonStr, limit * 2]; // ambil kandidat lebih banyak untuk filter

      final conditions = <String>[];
      if (provenance != 'all') {
        conditions.add('c.provenance = ?');
        params.add(provenance);
      }
      if (contentType != 'all') {
        conditions.add('a.content_type = ?');
        params.add(contentType);
      }
      if (conditions.isNotEmpty) {
        sql += ' WHERE ' + conditions.join(' AND ');
      }
      sql += ' ORDER BY v.distance ASC LIMIT ?';
      params.add(limit);

      rows = await _dbClient!.query(sql, params);
    } else {
      // Fallback: Cosine Distance brute-force jika DiskANN index belum terpasang
      var sql = '''
        SELECT 
          c.article_id AS id,
          a.title,
          a.category,
          a.content_type,
          a.provenance,
          a.author_or_speaker AS author,
          a.summary,
          c.chunk_content AS snippet,
          vector_distance_cos(c.embedding, vector32(?)) AS distance
        FROM article_chunks c
        JOIN articles a ON a.id = c.article_id
        WHERE c.embedding IS NOT NULL
      ''';
      final params = <dynamic>[vectorJsonStr];

      if (provenance != 'all') {
        sql += ' AND c.provenance = ?';
        params.add(provenance);
      }
      if (contentType != 'all') {
        sql += ' AND a.content_type = ?';
        params.add(contentType);
      }
      sql += ' ORDER BY distance ASC LIMIT ?';
      params.add(limit);

      rows = await _dbClient!.query(sql, params);
    }

    // Dedup per artikel (ambil chunk paling relevan untuk artikel tersebut)
    final seen = <String>{};
    final results = <SearchResultItem>[];

    for (final row in rows) {
      final aid = row['id'] as String;
      if (seen.contains(aid)) continue;
      seen.add(aid);

      final distance = (row['distance'] as num?)?.toDouble() ?? 1.0;
      final similarityScore = (1.0 - distance).clamp(0.0, 1.0);

      results.add(SearchResultItem(
        id: aid,
        title: row['title'] as String,
        category: row['category'] as String,
        contentType: row['content_type'] as String,
        provenance: row['provenance'] as String,
        author: row['author'] as String?,
        summary: row['summary'] as String? ?? '',
        snippet: row['snippet'] as String?,
        score: similarityScore,
      ));

      if (results.length >= limit) break;
    }

    return results;
  }

  /// 2. Pencarian Leksikal FTS5 (BM25)
  Future<List<SearchResultItem>> searchLexical({
    required String query,
    String provenance = 'all',
    String contentType = 'all',
    int limit = 10,
  }) async {
    if (_dbClient == null) throw StateError('Service belum diinisialisasi');

    final cleanQuery = query.replaceAll(RegExp(r'[^\w\s]+'), ' ').trim();
    if (cleanQuery.isEmpty) return [];

    final ftsTokens = cleanQuery
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .map((t) => '"$t"')
        .join(' AND ');

    var sql = '''
      SELECT 
        a.id,
        a.title,
        a.category,
        a.content_type,
        a.provenance,
        a.author_or_speaker AS author,
        a.summary
      FROM articles_fts fts
      JOIN articles a ON a.rowid = fts.rowid
      WHERE articles_fts MATCH ?
    ''';
    final params = <dynamic>[ftsTokens];

    if (provenance != 'all') {
      sql += ' AND a.provenance = ?';
      params.add(provenance);
    }
    if (contentType != 'all') {
      sql += ' AND a.content_type = ?';
      params.add(contentType);
    }

    sql += ' ORDER BY bm25(articles_fts), a.id LIMIT ?';
    params.add(limit);

    final rows = await _dbClient!.query(sql, params);
    return rows.map((r) => SearchResultItem(
      id: r['id'] as String,
      title: r['title'] as String,
      category: r['category'] as String,
      contentType: r['content_type'] as String,
      provenance: r['provenance'] as String,
      author: r['author'] as String?,
      summary: r['summary'] as String? ?? '',
    )).toList();
  }

  /// 3. Hybrid Search (FTS5 + LibSQL Vector via Reciprocal Rank Fusion)
  /// Menggabungkan kekuatan kata kunci (istilah hadits/Arab) dan pemahaman semantik (konteks emosi)
  Future<List<SearchResultItem>> searchHybrid({
    required String queryText,
    required Float32List queryEmbedding,
    String provenance = 'all',
    String contentType = 'all',
    int limit = 5,
    double rrfConstant = 60.0,
  }) async {
    // Jalankan pencarian leksikal dan semantik secara paralel
    final lexicalFuture = searchLexical(
      query: queryText,
      provenance: provenance,
      contentType: contentType,
      limit: 30,
    );
    final semanticFuture = searchSemantic(
      queryEmbedding: queryEmbedding,
      provenance: provenance,
      contentType: contentType,
      limit: 30,
    );

    final results = await Future.wait([lexicalFuture, semanticFuture]);
    final lexicalHits = results[0];
    final semanticHits = results[1];

    final rrfScores = <String, double>{};
    final articleMap = <String, SearchResultItem>{};

    // Skor FTS5 (Rank 0..N)
    for (int i = 0; i < lexicalHits.length; i++) {
      final item = lexicalHits[i];
      articleMap[item.id] = item;
      rrfScores[item.id] = (rrfScores[item.id] ?? 0.0) + (1.0 / (rrfConstant + i));
    }

    // Skor LibSQL Vector (Rank 0..N)
    for (int i = 0; i < semanticHits.length; i++) {
      final item = semanticHits[i];
      if (!articleMap.containsKey(item.id)) {
        articleMap[item.id] = item;
      }
      rrfScores[item.id] = (rrfScores[item.id] ?? 0.0) + (1.0 / (rrfConstant + i));
    }

    // Urutkan berdasarkan skor RRF tertinggi
    final sortedIds = rrfScores.keys.toList()
      ..sort((a, b) => rrfScores[b]!.compareTo(rrfScores[a]!));

    return sortedIds.take(limit).map((id) {
      final base = articleMap[id]!;
      return SearchResultItem(
        id: base.id,
        title: base.title,
        category: base.category,
        contentType: base.contentType,
        provenance: base.provenance,
        author: base.author,
        summary: base.summary,
        snippet: base.snippet,
        score: rrfScores[id],
      );
    }).toList();
  }
}
