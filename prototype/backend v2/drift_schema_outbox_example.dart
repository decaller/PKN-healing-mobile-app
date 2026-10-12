// ========================================================================
// PKN HEALING FLUTTER CLIENT - DRIFT OUTBOX SYNC SCHEMA & REPOSITORY
// Mengimplementasikan Pola Outbox Ringan (Dirty Flag) untuk Sinkronisasi Directus
// ========================================================================

import 'package:drift/drift.dart';

// ------------------------------------------------------------------------
// 1. Skema Tabel Pengguna Lokal dengan Kolom Status Sinkronisasi
// ------------------------------------------------------------------------

enum SyncStatus {
  synced,
  pending,
  deleted,
}

@DataClassName('UserBookmarkEntry')
class UserBookmarksTable extends Table {
  TextColumn get id => text()(); // UUIDv4 yang dibuat di client
  TextColumn get articleId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))(); // 'synced', 'pending', 'deleted'

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserNoteEntry')
class UserNotesTable extends Table {
  TextColumn get id => text()(); // UUIDv4 yang dibuat di client
  TextColumn get articleId => text()();
  TextColumn get content => text()();
  DateTimeColumn get clientUpdatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))(); // 'synced', 'pending', 'deleted'

  @override
  Set<Column> get primaryKey => {id};
}

// ------------------------------------------------------------------------
// 2. Repositori Sinkronisasi Outbox (Alur Push & Pull ke Directus)
// ------------------------------------------------------------------------

abstract class DirectusApiClient {
  Future<void> pushNotesBatch(List<Map<String, dynamic>> notes);
  Future<List<Map<String, dynamic>>> pullNotesDelta(DateTime since);
}

class UserNotesOutboxRepository {
  // Catatan: Asumsikan db adalah instance database Drift yang dihasilkan
  final dynamic db;
  final DirectusApiClient apiClient;

  UserNotesOutboxRepository({required this.db, required this.apiClient});

  /// 1. Local-First Write: Simpan seketika di ponsel tanpa lag internet
  Future<void> saveNoteLocalFirst({
    required String id,
    required String articleId,
    required String content,
  }) async {
    // Simpan ke SQLite lokal dengan status 'pending'
    /*
    await db.into(db.userNotesTable).insertOnConflictUpdate(
      UserNotesTableCompanion(
        id: Value(id),
        articleId: Value(articleId),
        content: Value(content),
        clientUpdatedAt: Value(DateTime.now()),
        syncStatus: const Value('pending'),
      ),
    );
    */
    // UI langsung terupdate via StreamProvider
  }

  /// 2. Background Push: Mengirim record yang tertunda saat koneksi online aktif
  Future<void> pushPendingNotes() async {
    // Ambil semua baris dengan sync_status == 'pending'
    // final pendingNotes = await (db.select(db.userNotesTable)..where((tbl) => tbl.syncStatus.equals('pending'))).get();

    // if (pendingNotes.isEmpty) return;

    // Payload dikirim secara batch ke endpoint Directus: POST /items/user_notes
    // try {
    //   await apiClient.pushNotesBatch(pendingPayload);
    //   // Update status lokal menjadi 'synced'
    // } catch (e) {
    //   // Tetap simpan sebagai pending dan coba lagi pada sync cycle berikutnya
    // }
  }

  /// 3. Delta Pull: Menarik catatan baru dari server sejak timestamp terakhir
  Future<void> pullRemoteChanges(DateTime lastSyncTime) async {
    // final remoteDeltas = await apiClient.pullNotesDelta(lastSyncTime);
    // Merge ke database lokal dengan status 'synced'
  }
}
