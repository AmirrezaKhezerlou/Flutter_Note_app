import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'NoteDB.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE note (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT,
            date TEXT,
            title TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertData(String content, String date,String title) async {
    Database db = await database;
    await db.insert('note', {'content': content, 'date': date,'title':title},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getDataByDate() async {
    Database db = await database;
    return await db.query('note');
  }
  

   Future<void> deleteNoteByID(int id) async {
    Database db = await database;
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<void> updateNote(int id, String newTitle, String newContent, String newDate) async {
    Database db = await database;
    await db.update(
      'note',
      {'title': newTitle, 'content': newContent, 'date': newDate},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> searchNotes(String searchText) async {
    Database db = await database;
    return await db.query(
      'note',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$searchText%', '%$searchText%'],
    );
  }


}
