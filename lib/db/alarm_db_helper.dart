import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/alarm.dart';

const _dbName = 'alarm.db';
const _alarmTable = 'alarm_table';
const _dbVersion = 1;

// DO NOT USE THIS WITHOUT PROVIDER !!
class AlarmDBHelper {
  // create new item
  static Future<int?> insertItem(Alarm alarm) async {
    try {
      final db = await _db();
      final data = alarm.toJson();
      final result = await db.insert(
        _alarmTable,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );

      return result;
    } catch (ex) {
      Logger().e(ex);
      return null;
    }
  }

  static Future<int?> insertItems(List<Alarm> alarms) async {
    try {
      final db = await _db();
      for (int i = 0; i < alarms.length; i++) {
        final data = alarms[i].toJson();
        await db.insert(
          _alarmTable,
          data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace,
        );
      }

      return 1;
    } catch (ex) {
      Logger().e(ex);
      return null;
    }
  }

  static Future<List<Alarm>?> getItems() async {
    try {
      final db = await _db();
      final json = await db.query(_alarmTable, orderBy: 'idx');
      final result = json.map((e) => Alarm.fromJson(e)).toList();
      return result;
    } catch (ex) {
      Logger().e(ex);
      return null;
    }
  }

  static Future<Alarm?> getItem(int id) async {
    try {
      final db = await _db();
      final json = await db.query(
        _alarmTable,
        where: 'idx = ?',
        whereArgs: [id],
        limit: 1,
      );

      return json.map((e) => Alarm.fromJson(e)).first;
    } catch (ex) {
      Logger().e(ex);
      return null;
    }
  }

  static Future<int?> updateItem({
    required Alarm alarm,
  }) async {
    try {
      final db = await _db();
      final result = await db.update(
        _alarmTable,
        alarm.toJson(),
        where: 'idx = ?',
        whereArgs: [alarm.idx],
      );

      return result;
    } catch (ex) {
      Logger().e(ex);
      return null;
    }
  }

  static Future<int?> updateItems({
    required List<Alarm> alarmData,
  }) async {
    try {
      final db = await _db();
      for (int i = 0; i < alarmData.length; i++) {
        await db.update(
          _alarmTable,
          alarmData[i].toJson(),
          where: 'idx = ?',
          whereArgs: [
            alarmData[i].idx,
          ],
        );
      }

      return 1;
    } catch (ex) {
      Logger().e(ex);
      return null;
    }
  }

  static Future<void> deleteItem(int idx) async {
    try {
      final db = await _db();
      await db.delete(
        _alarmTable,
        where: 'idx = ?',
        whereArgs: [idx],
      );
    } catch (ex) {
      Logger().e(ex);
    }
  }

  static Future<void> deleteAll() async {
    final db = await _db();
    db.rawQuery('DELETE FROM $_alarmTable');
  }

  // get my db
  static Future<sql.Database> _db() async {
    return sql.openDatabase(_dbName, version: _dbVersion, onCreate: (
      sql.Database database,
      int version,
    ) async {
      await _createTables(database);
    });
  }

  static Future<void> _createTables(sql.Database database) async {
    await database.execute(
      'CREATE TABLE $_alarmTable('
      'idx INTEGER PRIMARY KEY, '
      'label TEXT, '
      'timeOfDay TEXT, '
      'isAlive INTEGER)',
    );
  }
}
