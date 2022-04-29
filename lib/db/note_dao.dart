import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class NoteDao {

  static const _databaseName = "SimpleNoteTaker.db";
  static const _databaseVersion = 1;

  static const table = 'playlist';
  static const columnIdNote = 'id_note';
  static const columnTitle = 'title';
  static const columnText = 'text';

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  NoteDao._privateConstructor();
  static final NoteDao instance = NoteDao._privateConstructor();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnIdNote INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnText TEXT
          )
          ''');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY id_note DESC');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdNote];
    return await db.update(table, row, where: '$columnIdNote = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdNote = ?', whereArgs: [id]);
  }

}
