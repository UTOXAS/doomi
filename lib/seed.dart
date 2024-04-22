import 'package:doomi/model/task.dart';
import 'package:doomi/util/database_helper.dart';

class Seed {
  static Future<void> printTasks() async {
    final tasks = await DatabaseHelper().getTasks();

    // Print all tasks
    for (var task in tasks) {
      print('Task: ${task.title}');
      if (task.description != null) {
        print('  Description: ${task.description}');
      }
      print('  Priority: ${task.priority}');
      print('  Completed: ${task.isCompleted}');
      if (task.reminder != null) {
        print('  Reminder: ${task.reminder}');
      }
      print('---');
    }
  }

  static Future<void> addToDatabase() async {
    // await DatabaseHelper().deleteAllTasks();
    await DatabaseHelper().deleteAndRecreateTable();

    // Create 5 tasks directly
    final tasks = [
      Task(title: 'Buy groceries', priority: Priority.medium),
      Task(
        title: 'Finish project report',
        description: 'Due next week!',
        priority: Priority.high,
      ),
      Task(title: 'Call mom', reminder: DateTime.now().add(Duration(hours: 2))),
      Task(title: 'Clean the house', priority: Priority.low),
      Task(
          title: 'Go for a walk',
          description: 'Fresh air!',
          reminder: DateTime.now().add(Duration(days: 1))),
    ];

    // Insert each task into the database
    for (var task in tasks) {
      await DatabaseHelper().insertTask(task);
    }
  }
}
