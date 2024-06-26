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
            priority INTEGER,
            isCompleted INTEGER NOT NULL DEFAULT 0,
            reminder DATETIME
          )
        ''');
      },
      version: 1,
    );
  }

  // Create a new task
  static Future<int> insertTask(Task task) async {
    final db = await getDatabase();
    return await db.insert(_tableName, task.toMap());
  }

  // Read all tasks
  static Future<List<Task>> getTasks() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  // Read a specific task by ID
  static Future<Task?> getTask(int id) async {
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
  static Future<int> updateTask(Task task) async {
    final db = await getDatabase();
    return await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<void> updateTaskCompletion(int taskId, bool isComplete) async {
    final db = await getDatabase();
    await db.update(
      _tableName,
      {'isCompleted': isComplete}, // Set isComplete to provided value
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  // Delete a task
  static Future<int> deleteTask(int id) async {
    final db = await getDatabase();
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all tasks
  static Future<int> deleteAllTasks() async {
    final db = await getDatabase();
    return await db.delete(_tableName);
  }

  static Future<void> deleteAndRecreateTable() async {
    final db = await getDatabase();
    await db.execute('DROP TABLE IF EXISTS $_tableName');
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        priority INTEGER,
        isCompleted INTEGER NOT NULL DEFAULT 0,
        reminder DATETIME
      )
    ''');
  }
}
