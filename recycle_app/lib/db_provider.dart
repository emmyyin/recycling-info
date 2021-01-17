import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:recycle_app/models/recycleable.dart';
import 'package:recycle_app/models/hazardous_material.dart';
import 'package:recycle_app/models/recycle_places.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    print("initDB");
    // Construct the path to the app's writable database file:
    var dbDir = await getDatabasesPath();
    String dbPath = join(dbDir, "app.db");

    // Delete any existing database:
    await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("../database.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    _database = await openDatabase(dbPath);
    print("initDB done");
  }

  
  Future<List<HazardousMaterial>> getAllHazardousMataerials() async {
    print("in getAllHazardousMataerials");
    final db = await database;
    print("getting results");

    // TODO: Gets stuck here?
    List<Map> results =
        await db.rawQuery('SELECT * FROM sqlite_master WHERE type="table"');
        
    print("got results");
    List<HazardousMaterial> hazardousMataerials = new List();
    results.forEach((result) {
      HazardousMaterial material = HazardousMaterial.fromMap(result);
      hazardousMataerials.add(material);
      print(material.name);
    });
    print("return from getAllHazardousMataerials");
    return hazardousMataerials;
  }
}
