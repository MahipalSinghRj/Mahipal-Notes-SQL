import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";



  ///Create table in data base
  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, habits TEXT NOT NULL, address TEXT NOT NULL, date TEXT NOT NULL, isFavorite INTEGER);"),
        version: _version);
  }

///Insert data
  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    return await db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

///Update function
  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///Delete function
  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  ///Get all data function
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

  ///For search single item
  Future<List<Note>?> searchFilterList({required String searchKeyword}) async {
    final db = await _getDB();

    List<Map<String, dynamic>> allRows= await db .query('Note', where: 'title LIKE ?', whereArgs: ['%$searchKeyword%']);

    List<Note> searchList=allRows.map((title) => Note.fromJson(title)).toList();

   return searchList;
  }

  ///For search multiple item
  Future<List<Note>?> searchFilterWithMultipleItem({required String searchKeyword}) async {
    final db = await _getDB();

    const query = '''
    SELECT * 
    FROM Note 
    WHERE title LIKE ? 
    OR description LIKE ? 
    OR habits LIKE ? 
    OR address LIKE ?
  ''';

    final whereArgs = [
      '%$searchKeyword%',
      '%$searchKeyword%',
      '%$searchKeyword%',
      '%$searchKeyword%',
    ];

    List<Map<String, dynamic>> allRows = await db.rawQuery(query, whereArgs);

    List<Note> searchList = allRows.map((title) => Note.fromJson(title)).toList();

    return searchList;
  }




}
