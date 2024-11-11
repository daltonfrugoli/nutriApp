import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;


class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        hash_password TEXT NOT NULL
      )
    ''');

    // Criação da tabela que armazena o usuario logado
    await database.execute('''
      CREATE TABLE logged (
        id INTEGER PRIMARY KEY,
        email TEXT NOT NULL,
        hash_password TEXT NOT NULL
      )
    ''');

    // Criação da tabela usuario com relacionamento a accounts
    await database.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        birth TEXT NOT NULL,
        picture_path TEXT,
        account_id INTEGER,
        FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE
      )
    ''');

    // Criação da tabela alimento com relacionamento a accounts
    await database.execute('''
      CREATE TABLE food (
        name TEXT PRIMARY KEY,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        picture_path TEXT,
        account_id INTEGER,
        FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE
      )
    ''');

    // Criação da tabela cardapio com relacionamento a usuario
    await database.execute('''
      CREATE TABLE menu (
        user_name TEXT PRIMARY KEY,
        breakfast_option1 TEXT,
        breakfast_option2 TEXT,
        breakfast_option3 TEXT,
        lunch_option1 TEXT,
        lunch_option2 TEXT,
        lunch_option3 TEXT,
        lunch_option4 TEXT,
        lunch_option5 TEXT,
        dinner_option1 TEXT,
        dinner_option2 TEXT,
        dinner_option3 TEXT,
        dinner_option4 TEXT,
        account_id INTEGER,
        FOREIGN KEY (user_name) REFERENCES usuario(name) ON DELETE CASCADE
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
      return -1; // Retorno opcional em caso de erro
    }
  }

  static Future<void> setLoggedAccount(Map<String, dynamic> account) async {
    final db = await SQLHelper.db();
    await db.insert('logged', account);
  } 

  static Future<void> deleteLoggedAccount() async {
    final db = await SQLHelper.db();
    await db.delete('logged');
  }

  static Future<List<Map<String, dynamic>>> getLoggedAccount() async {
    final db = await SQLHelper.db();
    return db.query('logged');
  }

  
  static Future<int> createUser(String name, String birth, String picturePath, int accountId) async {
    final db = await SQLHelper.db();

    final data = {'name': name, 'birth': birth, 'picture_path': picturePath, 'account_id': accountId};
    final id = await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  
  static Future<int> createFood(String name, String category, String type, String picturePath, int accountId) async {
    final db = await SQLHelper.db();

    final data = {'name': name, 'category': category, 'type': type, 'picture_path': picturePath, 'account_id': accountId};
    final id = await db.insert('food', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createMenu(
    String userName,
    String breakfastOption1, 
    String breakfastOption2, 
    String breakfastOption3,
    String lunchOption1,
    String lunchOption2,
    String lunchOption3,
    String lunchOption4,
    String lunchOption5,
    String dinnerOption1,
    String dinnerOption2,
    String dinnerOption3,
    String dinnerOption4,
    int accountId) async {
    final db = await SQLHelper.db();

    final data = {
      'user_name': userName,
      'breakfast_option1': breakfastOption1,
      'breakfast_option2': breakfastOption2,
      'breakfast_option3': breakfastOption3,
      'lunch_option1': lunchOption1,
      'lunch_option2': lunchOption2,
      'lunch_option3': lunchOption3,
      'lunch_option4': lunchOption4,
      'lunch_option5': lunchOption5,
      'dinner_option1': dinnerOption1,
      'dinner_option2': dinnerOption2,
      'dinner_option3': dinnerOption3,
      'dinner_option4': dinnerOption4,
      'account_id': accountId
    };
    final id = await db.insert('menu', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUser(accountId) async {
    final db = await SQLHelper.db();
    return db.query('user', where: "account_id = ?", whereArgs: [accountId]);
  }

  static Future<List<Map<String, dynamic>>> getFood(accountId) async {
    final db = await SQLHelper.db();
    return db.query('food', where: "account_id = ?", whereArgs: [accountId]);
  }

  static Future<List<Map<String, dynamic>>> getMenu(accountId) async {
    final db = await SQLHelper.db();
    return db.query('menu', where: "account_id = ?", whereArgs: [accountId]);
  }

  static Future<List<Map<String, dynamic>>> getBreakfast(accountId) async {
    final db = await SQLHelper.db();
    return db.query('food', where: "category = ? AND account_id = ?", whereArgs: ['Breakfast', accountId]);
  }

  static Future<List<Map<String, dynamic>>> getLunch(accountId) async {
    final db = await SQLHelper.db();
    return db.query('food', where: "category = ? AND account_id = ?", whereArgs: ['Lunch', accountId]);
  }

  static Future<List<Map<String, dynamic>>> getDinner(accountId) async {
    final db = await SQLHelper.db();
    return db.query('food', where: "category = ? AND account_id = ?", whereArgs: ['Dinner', accountId]);
  }

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
