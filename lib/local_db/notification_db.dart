import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/local_db/db_provider.dart';
import 'package:weight_loss_app/modules/setting/notifications/model/notification_model.dart';

class RemNotifyDBProvider {
  static const tableName = 'Reminder';
  static const keyRemisOn = 'rem_isOn';
  static const keyRemName = 'rem_name';
  static const keyRemTime = 'rem_time';
  static const keyRemImageUrl = 'rem_img_url';

  static const createTable =
      "CREATE TABLE $tableName($keyRemName TEXT PRIMARY KEY,$keyRemTime TEXT,$keyRemImageUrl TEXT,$keyRemisOn INTEGER)";
  static const dropTable = 'DROP TABLE IF EXIST $tableName';

  Future<bool> insertReminder(ReminderNotifyModel reminder) async {
    Database db = await DBProvider.database;
    try {
      var rowID = await db.insert(tableName, reminder.toMap());
      return rowID > 0;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteReminder({required String remName}) async {
    Database db = await DBProvider.database;
    var rowID =
        await db.delete(tableName, where: "$remName =?", whereArgs: [remName]);
    return rowID > 0;
  }

  Future<bool> updateReminder(ReminderNotifyModel reminder) async {
    Database db = await DBProvider.database;
    var rowID = await db.update(tableName, reminder.toMap(),
        where: "$keyRemName =?", whereArgs: [reminder.name]);
    return rowID > 0;
  }

  Future<List<ReminderNotifyModel>> fetchReminderList() async {
    Database db = await DBProvider.database;
    var rowID = await db.query(tableName);

    return rowID.map((e) => ReminderNotifyModel.fromMap(e)).toList();
  }

  Future<ReminderNotifyModel> fetchReminder({required String remName}) async {
    Database db = await DBProvider.database;
    var rowID = await db.query(
      tableName,
      where: "$keyRemName =?",
      whereArgs: [remName],
      limit: 1,
    );

    return ReminderNotifyModel.fromMap(rowID.first);
  }

  var remNotilist = <ReminderNotifyModel>[
    ReminderNotifyModel(
        name: "BreakFast",
        isOn: 1,
        time: "8:00 AM",
        remImgUrl: AppAssets.breakFast),
    ReminderNotifyModel(
        name: "Lunch", isOn: 1, time: "12:00 PM", remImgUrl: AppAssets.lunch),
    ReminderNotifyModel(
        name: "Snack",
        isOn: 1,
        time: "3:00 PM",
        remImgUrl: AppAssets.snackDairyIconSvgUrl),
    ReminderNotifyModel(
        name: "Dinner", isOn: 1, time: "5:30 PM", remImgUrl: AppAssets.dinner),
    ReminderNotifyModel(
        name: "Workout",
        isOn: 1,
        time: "7:00 PM",
        remImgUrl: AppAssets.workout),
    ReminderNotifyModel(
        name: "Sleep",
        isOn: 1,
        time: "10:00 PM",
        remImgUrl: AppAssets.sleepNotification),
  ];
}
