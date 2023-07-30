import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/models/database/saved_news_model.dart';
import 'package:weather/models/database/wanted_places_model.dart';

import '../models/database/saved_cities_model.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

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
    final path = join(documenstDirectory.path, '8vaModification.db');

//create dataBase

    return await openDatabase(
      path,
      version: 5,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
CREATE TABLE News(
  id INTEGER PRIMARY KEY,
  title TEXT,
  url TEXT,
  urlToImage TEXT,
  isButtonPressed BOOL
)
''');
        await db.execute('''
CREATE TABLE Cities(
  id INTEGER PRIMARY KEY,
  title TEXT,
  temperature TEXT,
  wind TEXT,
  updated TEXT,
  coords TEXT

)
''');
        await db.execute('''
CREATE TABLE Places(
  id INTEGER PRIMARY KEY,
  placeName TEXT,
  placeCoords TEXT

)
''');
      },
    );
  }

  //*************************************************** */
//*METHODS TO NEWS
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

//*METHODS FOR CITIES
  //**************************************************** */

  Future<int> citySave(SavedCitiesModel citySave) async {
    final db = await database;

    final res = await db!.insert('Cities', citySave.toJson());

    return res;
  }

  Future<List<SavedCitiesModel>?> getAllCities() async {
    final db = await database;
    final res = await db!.query('Cities');

    return res.isNotEmpty
        ? res.map((e) => SavedCitiesModel.fromJson(e)).toList()
        : [];
  }

  Future<int?> deleteCities(int id) async {
    final db = await database;
    final res = await db!.delete(
      'Cities',
      where: 'id = ?',
      whereArgs: [id],
    );
    return res;
  }
  //**************************************************** */
  //*METHOD FOR FINDED PLACES

  Future<int> savedPlace(WantedPlacesModel savePlace) async {
    final db = await database;

    final res = await db!.insert('Places', savePlace.toJson());
    return res;
  }

  Future<List<WantedPlacesModel>?> getAllPlaces() async {
    final db = await database;
    final res = await db!.query('Places');

    return res.isNotEmpty
        ? res.map((e) => WantedPlacesModel.fromJson(e)).toList()
        : [];
  }

  Future<int?> deletePlace(int id) async {
    final db = await database;
    final res = await db!.delete(
      'Places',
      where: 'id = ?',
      whereArgs: [id],
    );
    return res;
  }

  //**************************************************** */
}
