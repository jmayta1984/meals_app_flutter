import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  final int version =1;
  final String databaseName = 'meals.db';
  final String tableName = 'meals';

  Database? _db;
  Future<Database> openDB() async{
    _db ??= await openDatabase(join(await getDatabasesPath(),databaseName),onCreate: (database, version) {
      database.execute('create table $tableName (id primary key text, name text )');
    }, version: version);
    return _db as Database;
  }
}