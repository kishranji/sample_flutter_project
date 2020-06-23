import 'dart:async';
import 'dart:core';

import 'package:animation_rive/model/users.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String userTable = 'user_table';
  String colId = 'id';
  String colName = 'name';
  String colEmail = 'email';
  String colPassword = 'password';
  String colPhoneNumber = 'phone_number';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'users.db';

    // Open/create the database at a given path
    var todosDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
            '$colPassword TEXT, $colPhoneNumber TEXT, $colEmail TEXT)');
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.query(userTable, orderBy: '$colName ASC');
    return result;
  }

  Future<int> insertUser(Users user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  Future<int> updateUser(Users user) async {
    var db = await this.database;
    var result = await db.update(userTable, user.toMap(),
        where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<Users> getUserWithMobile(String mobile) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "Select * From $userTable where $colPhoneNumber = '" + mobile + "'");
    if (result.length > 0) {
      Users aUser = Users.fromMapObject(result[0]);
      return aUser;
    }
    return null;
  }

  Future<Users> getUser(String name, String password) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "Select * From $userTable where $colEmail = '" +
            name +
            "' and $colPassword = '" +
            password +
            "'");
    Users aUser = Users.fromMapObject(result[0]);
    return aUser;
  }

  Future<int> checkUser(String name, String phone) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "Select * From $userTable where $colEmail = '" +
            name +
            "' or $colPhoneNumber = '" +
            phone +
            "'");
    return result.length;
  }

  Future<List<Users>> getUserList() async {
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count =
        userMapList.length; // Count the number of map entries in db table

    List<Users> userList = List<Users>();
    for (int i = 0; i < count; i++) {
      userList.add(Users.fromMapObject(userMapList[i]));
    }

    return userList;
  }
}
