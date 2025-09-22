import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'funcionario.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() {
    return _instance;
  }
  DatabaseHelper._internal();

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path;
    if(kIsWeb) {
      path='func_app_web.db';
    } else {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      path = join(documentsDirectory.path,'func_app.db');
    }
    return await openDatabase(
      path, version:1, onCreate: _onCreate
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE FUNCIONARIOS(
        RE INTEGER PRIMARY KEY AUTOINCREMENT,
        NOME: TEXT,
        SALARIO: DOUBLE      
      )
    ''');
  }
  // operações CRUD 
  Future<int> insertFuncionario(Funcionario funcionario) async {
    final db = await database;
    return await db.insert('FUNCIONARIOS', funcionario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Funcionario>> getFuncionarios() async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query('FUNCIONARIOS');
    return List.generate(maps.length,(i) {
      return Funcionario.fromMap(maps[i]);
    });
  }

  Future<Funcionario?> getFuncionarioByRe(int re) async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(
      'FUNCIONARIOS',
      where: 're = ?',
      whereArgs: [re]);
    if (maps.isNotEmpty) {
      return Funcionario.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateFuncionario(Funcionario funcionario) async {
    final db = await database;
    return await db.update(
      'FUNCIONARIOS',
      funcionario.toMap(),
      where: 're = ?',
      whereArgs: [funcionario.re]
    );
  }

  Future<int> deleteFuncionario(int re) async {
    final db = await database;
    return await db.delete(
      'FUNCIONARIOS',
      where: 're = ?',
      whereArgs: [re]
    );
  }

  Future<void> close() async {
    final db = _database;
    if(db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }
}