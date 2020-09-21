import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

abstract class dataBase{
  static var _dbDir;
  static const String _dbName = 'ectheory.db';
  static var _dbPath;
  static Database _dataBase;

  static init()async{
    _dbDir = await getDatabasesPath();
    _dbPath = join(_dbDir, _dbName);
    if (await File(_dbPath).exists()){
      _dataBase = await openDatabase(_dbPath);
      return;
    }
    try{
      _copyDataBase(_dbPath);
      _dataBase = await openDatabase(_dbPath);
    } catch (ex){
      print (ex);
    }
  }

  static void _copyDataBase(String path) async{
    ByteData data = await rootBundle.load('assets/ectheory.db');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }

  static Future<List<Map>>select(String sql)async{
    //openDatabase(_dbPath);
    return await _dataBase.rawQuery(sql);
  }
}