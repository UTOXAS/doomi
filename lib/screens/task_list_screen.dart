import 'package:doomi/model/task.dart';
import 'package:doomi/util/database_helper.dart';
import 'package:doomi/widgets/priority_dropdown.dart';
import 'package:doomi/widgets/priority_row.dart';
import 'package:doomi/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Priority _selectedPriority = Priority.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            //  Text(
            //   'Doomi',
            //   style: GoogleFonts.kanit(fontSize: 16),
            // ),
            const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doomi',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Small tasks, big accomplishment',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Notification button pressed!');
            },
            icon: const Icon(Icons.notifications),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String value) => print('Selected value: $value'),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'Option 1',
                child: Text('Option 1'),
              ),
              const PopupMenuItem(
                value: 'Option 2',
                child: Text('Option 2'),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PriorityRow(
                selectedPriority: _selectedPriority,
                onPriorityChanged: (priority) {
                  _selectedPriority = priority;
                },
              ),
              SizedBox(
                height: 24,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Tasks',
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: DatabaseHelper.getTasks(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final tasks = snapshot.data!;
                        return ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskCard(
                              task: task,
                              onDelete: () => _deleteTask(task.id!),
                              onEdit: () => _editTask(task.id!),
                              onChecked: (isChecked) async {
                                await DatabaseHelper.updateTaskCompletion(
                                    task.id!, !task.isCompleted);
                                setState(() {});
                              },
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}'));
                      }

                      return const Center(child: CircularProgressIndicator());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deleteTask(int taskId) async {
    await DatabaseHelper.deleteTask(taskId);
    setState(() {});
  }

  void _editTask(int taskId) async {
    print('Edit Task: $taskId');
  }
}
