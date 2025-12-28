import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_sqflite/models/task_model.dart';
import 'package:todo_sqflite/models/category_model.dart';



class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _db;
  static const int _version = 2; //
  static const String _tableName = 'tasks';
  static const String _categoriesTable = 'categories';

  Future<Database> get mydb async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    try {
      String _path = join(await getDatabasesPath(), 'tasks.db');
      return await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) async {
          // جدول التاسكات
          await db.execute(
            '''
            CREATE TABLE $_tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              priority TEXT,
              dueDate TEXT,
              isCompleted INTEGER,
              category TEXT,
              createdAt TEXT
            )
            ''',
          );

          // جدول الكاتيجوريز
          await db.execute(
            '''
            CREATE TABLE $_categoriesTable(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT UNIQUE
            )
            ''',
          );

          // إدخال كاتيجوريز افتراضية
          for (final name in ['Work', 'Personal', 'Shopping', 'Health']) {
            await db.insert(_categoriesTable, {'name': name});
          }
        },

        //
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute(
              '''
              CREATE TABLE $_categoriesTable(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT UNIQUE
              )
              ''',
            );

            for (final name in ['Work', 'Personal', 'Shopping', 'Health']) {
              await db.insert(_categoriesTable, {'name': name});
            }
          }
        },
      );
    } catch (e) {
      print("DB Init Error: $e");
      rethrow;
    }
  }

  // ===== CRUD Methods for Tasks =====

  Future<int> insert(Task task) async {
    final db = await mydb;
    return await db.insert(_tableName, task.toJson());
  }

  Future<List<Map<String, dynamic>>> query() async {
    final db = await mydb;
    return await db.query(_tableName);
  }

  Future<int> delete(Task task) async {
    final db = await mydb;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> updateCompleted(int id) async {
    final db = await mydb;
    return await db.rawUpdate(
      '''
      UPDATE $_tableName
      SET isCompleted = ?
      WHERE id = ?
      ''',
      [1, id],
    );
  }

  Future<int> updateTask(Task task) async {
    final db = await mydb;
    return await db.update(
      _tableName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // ===== 🆕 Methods for Categories =====

  Future<int> insertCategory(Category category) async {
    final db = await mydb;
    return await db.insert(
      _categoriesTable,
      category.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Category>> getAllCategories() async {
    final db = await mydb;
    final List<Map<String, dynamic>> result =
    await db.query(_categoriesTable, orderBy: 'id ASC');
    return result.map((e) => Category.fromJson(e)).toList();
  }
}
