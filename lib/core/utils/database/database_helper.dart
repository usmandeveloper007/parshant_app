import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parshant_app/models/mybets_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? mydb;

  Future<Database> getDb() async {
    if (mydb != null) {
      return mydb!;
    } else {
      mydb = await initDb();
      return mydb!;
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "games.db");

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // Create gamesData table
      await db.execute('''
        CREATE TABLE gamesData (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          gameName TEXT NOT NULL,
          betStartTime TEXT NOT NULL,
          betCloseTime TEXT NOT NULL,
          lastResult TEXT NOT NULL,
          resultTime TEXT NOT NULL,
          afterResult INTEGER NOT NULL,
          changeSystem INTEGER NOT NULL,
          betDate INTEGER NOT NULL
        )
      ''');

      // Create changeGameData table
      await db.execute('''
        CREATE TABLE changeGameData (
          id INTEGER PRIMARY KEY AUTOINCREMENT,   
          isChange INTEGER NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE "MyBets" (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId TEXT NOT NULL,
          gameName TEXT NOT NULL,
          betDate INTEGER NOT NULL,
          resultDate TEXT NOT NULL,
          numbers TEXT NOT NULL,
          status TEXT NOT NULL,
          totalAmount INTEGER NOT NULL
        )
      ''');
    });
  }

  void addNotes({
    required String gameName,
    required String betStartTime,
    required String betCloseTime,
    required String lastResult,
    required String resultTime,
    required int afterResult,
    required int changeSystem,
    required int betDate,
  }) async {
    var db = await getDb();

    await db.insert(
      "gamesData",
      {
        "gameName": gameName,
        "betStartTime": betStartTime,
        "betCloseTime": betCloseTime,
        "lastResult": lastResult,
        "resultTime": resultTime,
        "afterResult": afterResult,
        "changeSystem": changeSystem,
        "betDate": betDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void addNotes2({
    required int isChange,
  }) async {
    var db = await getDb();

    await db.insert(
      "changeGameData",
      {
        "isChange": isChange,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void addMyBets({
    required String userId,
    required String resultDate,
    required int betDate,
    required String gameName,
    required String status,
    required String numbers,
    required num totalAmount,
  }) async {
    var db = await getDb();
    await db.insert(
      "MyBets",
      MyBet(
              userId: userId,
              resultDate: resultDate,
              betDate: betDate,
              gameName: gameName,
              status: status,
              numbers: numbers,
              totalAmount: totalAmount)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch data from gamesData table
  Future<List<Map<String, dynamic>>> fetchData() async {
    List<Map<String, dynamic>> games = [];
    var db = await getDb();
    games = await db.query("gamesData");
    return games;
  }

  // Fetch data from changeGameData table
  Future<List<Map<String, dynamic>>> fetchData2() async {
    List<Map<String, dynamic>> changeData = [];
    var db = await getDb();
    changeData = await db.query("changeGameData"); // Correct table name
    return changeData;
  }

  // Clear data from  table
  Future<void> clearTableData({required String tableName}) async {
    var db = await getDb();
    await db.delete(tableName); // Puri table ka data clear ho jayega
    print("✅ Table '$tableName' ka data clear ho gaya!");
  }

  Future<void> clearTableData2() async {
    try {
      var db = await getDb();
      await db.delete("gamesData");
      await db.delete("changeGameData");
      await db.delete("MyBets");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateChnageValue(int change) async {
    var db = await getDb();
    db.update("changeGameData", {
      "isChange": change,
    });
  }
}
