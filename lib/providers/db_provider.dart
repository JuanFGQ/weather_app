import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/models/saved_news_model.dart';

class DBprovider {
  static Database? _database;

  static final DBprovider db = DBprovider._();

  DBprovider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    Directory documenstDirectory = await getApplicationDocumentsDirectory();
    final path = join(documenstDirectory.path, 'NewsDB.db');

//create dataBase

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE News(
  id INTEGER PRIMARY KEY,
  title TEXT,
  url TEXT,
  urlToImage TEXT
)
''');
    });
  }

  Future<int> newSave(SavedNewsModel newSave) async {
    final db = await database;

    final res = await db!.insert('news', newSave.toJson());

    return res;
  }

  Future<List<SavedNewsModel>?> getAllNews() async {
    final db = await database;
    final res = await db!.query('News');

    return res.isNotEmpty
        ? res.map((e) => SavedNewsModel.fromJson(e)).toList()
        : [];
  }

  Future<int?> deleteNews(int id) async {
    final db = await database;
    final res = await db!.delete(
      'News',
      where: 'id = ?',
      whereArgs: [id],
    );
    return res;
  }

  Future<int?> deleteAllNews() async {
    final db = await database;

    final res = await db!.delete('News');

    return res;
  }
}