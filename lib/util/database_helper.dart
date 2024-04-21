import 'package:doomi/model/task.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = 'doomi.db';
  static const String _tableName = 'tasks';

  static Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    return await openDatabase(
      '$databasePath/$_databaseName',
      onCreate: (database, version) {
        database.execute('''
            CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            priority TEXT,
            isCompleted INTEGER NOT NULL DEFAULT 0,
            reminder DATETIME
          )
        ''');
      },
      version: 1,
    );
  }

  // Create a new task
  Future<int> insertTask(Task task) async {
    final db = await getDatabase();
    return await db.insert(_tableName, task.toMap());
  }

  // Read all tasks
  Future<List<Task>> getTasks() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  // Read a specific task by ID
  Future<Task?> getTask(int id) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Update an existing task
  Future<int> updateTask(Task task) async {
    final db = await getDatabase();
    return await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete a task
  Future<int> deleteTask(int id) async {
    final db = await getDatabase();
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all tasks
  Future<int> deleteAllTasks() async {
    final db = await getDatabase();
    return await db.delete(_tableName);
  }
}
