import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

// Dependencias de criptografia
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        hash_password TEXT NOT NULL
      )
    ''');

    // Criação da tabela usuario com relacionamento a accounts
    await database.execute('''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_nascimento TEXT NOT NULL,
        caminho_foto TEXT,
        account_id INTEGER,
        FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE
      )
    ''');

    // Criação da tabela alimento com relacionamento a accounts
    await database.execute('''
      CREATE TABLE alimento (
        nome TEXT PRIMARY KEY,
        categoria TEXT NOT NULL,
        tipo TEXT NOT NULL,
        caminho_foto TEXT,
        account_id INTEGER,
        FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE
      )
    ''');

    // Criação da tabela cardapio com relacionamento a usuario
    await database.execute('''
      CREATE TABLE cardapio (
        usuario_id INTEGER PRIMARY KEY,
        opcao_cafe1 TEXT,
        opcao_cafe2 TEXT,
        opcao_cafe3 TEXT,
        opcao_almoco1 TEXT,
        opcao_almoco2 TEXT,
        opcao_almoco3 TEXT,
        opcao_almoco4 TEXT,
        opcao_almoco5 TEXT,
        opcao_janta1 TEXT,
        opcao_janta2 TEXT,
        opcao_janta3 TEXT,
        opcao_janta4 TEXT,
        FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
      )
    ''');
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

// Retorna um único registro através do e-mail
  static Future<List<Map<String, dynamic>>> getAccount(
      String email) async {
    final db = await SQLHelper.db();
    return db.query('accounts',
        where: "email = ?", whereArgs: [email], limit: 1);
  }

  // Insere um novo registro
  static Future<int> createAccount(String email, String senha) async {
    final db = await SQLHelper.db();
    final data = {'email': email, 'hash_password': senha};

    try {
      final id = await db.insert(
        'accounts',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm
            .fail, // Define o comportamento em caso de conflito
      );
      return id; // Sucesso
    } catch (e) {
      print('Erro ao inserir item: $e');
      return -1; // Retorno opcional em caso de erro
    }
  }

  static String generateHash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /*static Future<int> createAccount(String email, String? password) async {
    final db = await SQLHelper.db();
    final data = {'email': email, 'hash_password': generateHash(password!)};

    try {
      final id = await db.insert(
        'accounts',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm
            .fail, // Define o comportamento em caso de conflito
      );
      return id; // Sucesso
    } catch (e) {
      print('Erro ao inserir item: $e');
      return -1; // Retorno opcional em caso de erro
    }
  }*/

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'nutriapp.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'description': descrption};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
