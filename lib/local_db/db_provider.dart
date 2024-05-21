import 'package:sqflite/sqflite.dart';
import 'package:weight_loss_app/local_db/notification_db.dart';

class DBProvider {
  static Database? _database;
  static Future<Database> get database async {
    var pathDirectory = await getDatabasesPath();
    var path = "${pathDirectory}reminder.db";
    return _database ??= await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(RemNotifyDBProvider.createTable);
      },
    );
  }
}
