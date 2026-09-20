import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'file_share_database.db');

    return await openDatabase(
      path,
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
  }

  /// Enable foreign keys for SQLite.
  /// This ensures that if a PeerDevice is deleted, its related Transfers can be cascaded.
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Create all tables in a single batch
  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    // 1. CurrentUser Table
    batch.execute('''
      CREATE TABLE current_user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        device_name TEXT,
        device_type TEXT,
        profile_image TEXT,
        bio TEXT,
        device_unique_id TEXT,
        created_at INTEGER,
        updated_at INTEGER
      )
    ''');

    // 2. PeerDevice Table
    batch.execute('''
      CREATE TABLE peer_device (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        device_unique_id TEXT,
        name TEXT,
        device_name TEXT,
        device_type TEXT,
        profile_image TEXT,
        bio TEXT,
        first_seen_at INTEGER,
        last_seen_at INTEGER
      )
    ''');

    // 3. Transfer Table
    batch.execute('''
      CREATE TABLE transfer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        peer_id INTEGER,
        direction TEXT,
        status TEXT,
        created_at INTEGER,
        started_at INTEGER,
        completed_at INTEGER,
        FOREIGN KEY (peer_id) REFERENCES peer_device (id) ON DELETE CASCADE
      )
    ''');

    // 4. TransferFile Table
    batch.execute('''
      CREATE TABLE transfer_file (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        transfer_id INTEGER,
        file_name TEXT,
        local_uri TEXT,
        file_type TEXT,
        file_size INTEGER,
        status TEXT,
        checksum TEXT,
        created_at INTEGER,
        completed_at INTEGER,
        FOREIGN KEY (transfer_id) REFERENCES transfer (id) ON DELETE CASCADE
      )
    ''');

    await batch.commit();
  }
}