import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = 'meals.db';
  final String tableName = 'meals';

  Database? _db;
  Future<Database> openDB() async {
    _db ??= await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version) {
      String query =
          'create table $tableName (id text primary key , name text )';
      log(query);
      database.execute(query);
    }, version: version);
    return _db as Database;
  }
}
