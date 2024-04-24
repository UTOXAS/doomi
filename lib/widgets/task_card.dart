import 'package:doomi/model/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Function onChecked;

  const TaskCard({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
    required this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Task.getColorForPriority(task.priority).withAlpha(100),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.12,
        constraints: const BoxConstraints(minHeight: 0.0),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                onChecked(value);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReminderRow(context),
                  const SizedBox(height: 4.0),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            _buildMenuIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderRow(BuildContext context) {
    if (task.reminder == null) return const SizedBox();
    // final remainingTime = task.reminder!.difference(DateTime.now());
    // final String formattedTime;
    // if (remainingTime.inDays > 0) {
    //   formattedTime = '${remainingTime.inDays}d';
    // } else if (remainingTime.inHours > 0) {
    //   formattedTime = '${remainingTime.inHours}h';
    // } else {
    //   formattedTime = '${remainingTime.inMinutes}m';
    // }

    String formattedDate = DateFormat('yMMMMd').format(task.reminder!);
    final frontColor = Colors.black45;
    return Row(
      children: [
        Icon(Icons.alarm, size: 16.0, color: frontColor),
        const SizedBox(width: 4.0),
        Text(
          formattedDate,
          style: TextStyle(fontSize: 12.0, color: frontColor),
        )
      ],
    );
  }

  Widget _buildMenuIcon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_horiz),
      iconSize: 20.0,
      color: Colors.grey[400],
      onPressed: () => showDialog(
        context: context,
        builder: (context) => _buildMenu(context),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () {
            onEdit();
            Navigator.pop(context);
          },
          child: const Text('Edit'),
        ),
        SimpleDialogOption(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        )
      ],
    );
  }
}
