 import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";

  List<Note> searchList=[];

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, habits TEXT NOT NULL, address TEXT NOT NULL, date TEXT NOT NULL, isFavorite INTEGER);"),
        version: _version);
  }

  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    return await db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // static Future<List<Note>?> getAllNotes() async {
  //   final db = await _getDB();
  //
  //   final List<Map<String, dynamic>> maps = await db.query("Note");
  //
  //   if (maps.isEmpty) {
  //     return null;
  //   }
  //   return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  // }
    Future<List<Note>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    // Reverse the list
    //searchList = List.generate(maps.length, (index) => Note.fromJson(maps[index])).reversed.toList();

    //return searchList;
      return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }

/*  static Future<List<Note>?> getAllNotes({String? searchQuery}) async {
    final db = await _getDB();

    String query = "SELECT * FROM Note";

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += " WHERE title LIKE '%$searchQuery%'";
    }

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }*/


}
