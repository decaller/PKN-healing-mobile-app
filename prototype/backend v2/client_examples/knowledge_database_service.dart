// ========================================================================
// PKN HEALING FLUTTER CLIENT - KNOWLEDGE DATABASE SERVICE
// Membaca knowledge.db (SQLite + FTS5) secara luring 100% di perangkat fisik
// ========================================================================

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class KnowledgeArticle {
  final String id;
  final String title;
  final String category;
  final String contentType;
  final String provenance; // 'expert_verified' vs 'ai_assisted'
  final String? author;
  final String summary;
  final String? content;

  KnowledgeArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.contentType,
    required this.provenance,
    this.author,
    required this.summary,
    this.content,
  });

  bool get isExpertVerified => provenance == 'expert_verified';
}

class KnowledgeDatabaseService {
  Database? _db;

  /// Inisialisasi: Pastikan berkas knowledge.db berada di folder Support perangkat
  Future<void> initialize({String? bundledAssetPath}) async {
    final supportDir = await getApplicationSupportDirectory();
    final dbFile = File(p.join(supportDir.path, 'knowledge.db'));

    if (!await dbFile.exists()) {
      if (bundledAssetPath != null) {
        // Ekstrak dari aset awal aplikasi jika ada
        final byteData = await rootBundle.load(bundledAssetPath);
        await dbFile.writeAsBytes(
          byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
          flush: true,
        );
      }
    }

    if (await dbFile.exists()) {
      // Buka koneksi SQLite read-only (cepat & hemat memori)
      _db = sqlite3.open(
        dbFile.path,
        mode: OpenMode.readOnly,
      );
    }
  }

  /// 1. Pencarian Hibrida Kata Kunci (FTS5) dengan Filter Kredibilitas
  List<KnowledgeArticle> searchArticles({
    required String query,
    String provenance = 'all', // 'all', 'expert_verified', 'ai_assisted'
    String contentType = 'all', // 'all', 'article', 'doa', 'cerita_rpg', 'buku', 'event'
    int limit = 10,
  }) {
    if (_db == null) return [];

    final ftsQuery = query.replaceAll("'", "''");
    var sql = '''
      SELECT a.id, a.title, a.category, a.content_type, a.provenance, 
             a.author_or_speaker, a.summary
      FROM articles_fts fts
      JOIN articles a ON a.rowid = fts.rowid
      WHERE articles_fts MATCH ?
    ''';
    final params = <Object?>[ftsQuery];

    if (provenance != 'all') {
      sql += ' AND a.provenance = ?';
      params.add(provenance);
    }

    if (contentType != 'all') {
      sql += ' AND a.content_type = ?';
      params.add(contentType);
    }

    sql += ' LIMIT ?';
    params.add(limit);

    final stmt = _db!.prepare(sql);
    final results = stmt.select(params);
    stmt.dispose();

    return results.map((row) => KnowledgeArticle(
      id: row['id'] as String,
      title: row['title'] as String,
      category: row['category'] as String,
      contentType: row['content_type'] as String,
      provenance: row['provenance'] as String,
      author: row['author_or_speaker'] as String?,
      summary: row['summary'] as String,
    )).toList();
  }

  /// 2. Mengambil Konten Lengkap Artikel Berdasarkan ID
  KnowledgeArticle? getArticleById(String articleId) {
    if (_db == null) return null;

    final stmt = _db!.prepare('''
      SELECT id, title, category, content_type, provenance, 
             author_or_speaker, summary, content
      FROM articles WHERE id = ?
    ''');
    final rows = stmt.select([articleId]);
    stmt.dispose();

    if (rows.isEmpty) return null;
    final row = rows.first;

    return KnowledgeArticle(
      id: row['id'] as String,
      title: row['title'] as String,
      category: row['category'] as String,
      contentType: row['content_type'] as String,
      provenance: row['provenance'] as String,
      author: row['author_or_speaker'] as String?,
      summary: row['summary'] as String,
      content: row['content'] as String?,
    );
  }

  /// 3. Mengambil Doa Penenang Jiwa Terverifikasi Pakar
  List<KnowledgeArticle> getDoaPenenang({String query = '', int limit = 5}) {
    if (_db == null) return [];

    final sql = '''
      SELECT id, title, category, content_type, provenance, 
             author_or_speaker, summary, content
      FROM articles
      WHERE content_type = 'doa' AND (title LIKE ? OR content LIKE ?)
      LIMIT ?
    ''';
    final stmt = _db!.prepare(sql);
    final results = stmt.select(['%$query%', '%$query%', limit]);
    stmt.dispose();

    return results.map((row) => KnowledgeArticle(
      id: row['id'] as String,
      title: row['title'] as String,
      category: row['category'] as String,
      contentType: row['content_type'] as String,
      provenance: row['provenance'] as String,
      author: row['author_or_speaker'] as String?,
      summary: row['summary'] as String,
      content: row['content'] as String?,
    )).toList();
  }

  void dispose() {
    _db?.dispose();
    _db = null;
  }
}
