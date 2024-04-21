import 'package:doomi/model/task.dart';
import 'package:doomi/util/database_helper.dart';

class Seed {
  static Future<void> addToDatabase() async {
    await DatabaseHelper().deleteAllTasks();

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
