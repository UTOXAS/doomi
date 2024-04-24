import 'package:doomi/model/task.dart';
import 'package:doomi/util/database_helper.dart';

class Seed {
  static Future<void> printTasks() async {
    final tasks = await DatabaseHelper.getTasks();

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
    await DatabaseHelper.deleteAndRecreateTable();

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
      await DatabaseHelper.insertTask(task);
    }
  }

  static Future<void> addMoreToTheDatabase() async {
    final tasks = createTenNewTasks();

    for (var task in tasks) {
      await DatabaseHelper.insertTask(task);
    }
  }

  static List<Task> createTenNewTasks() {
    return [
      Task(title: 'Write a blog post', priority: Priority.medium),
      Task(
        title: 'Review code for pull request',
        description: 'Don\'t forget unit tests!',
        priority: Priority.high,
      ),
      Task(
          title: 'Grocery shopping',
          reminder: DateTime.now().add(Duration(days: 2))),
      Task(title: 'Clean the apartment', priority: Priority.low),
      Task(
          title: 'Go for a run',
          description: 'Enjoy the fresh air!',
          reminder: DateTime.now().add(Duration(hours: 1))),
      Task(title: 'Finish design mockups', priority: Priority.high),
      Task(title: 'Learn a new programming language (Dart?)'),
      Task(
          title: 'Call parents',
          reminder: DateTime.now().add(Duration(days: 1))),
      Task(title: 'Organize desk', description: 'Declutter for better focus!'),
      Task(
          title: 'Read a book (for pleasure)',
          reminder: DateTime.now().add(Duration(days: 3))),
    ];
  }
}
