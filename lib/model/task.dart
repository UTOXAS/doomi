import 'package:flutter/material.dart';

class Task {
  final int? id;
  final String title;
  String? description;
  Priority priority;
  bool isCompleted;
  DateTime? reminder;

  Task({
    this.id,
    required this.title,
    this.description,
    this.priority = Priority.low,
    this.isCompleted = false,
    this.reminder,
  });

  void toggleCompletion() {
    isCompleted = !isCompleted;
  }

  @override
  String toString() {
    return 'Task(titke: $title, description: $description, priority: $priority, isCompleted: $isCompleted, reminder: $reminder)';
  }

  // Method to get background color based on priority
  static Color getColorForPriority(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.green; // Example color for low priority
      case Priority.medium:
        return Colors.yellow; // Example color for medium priority
      case Priority.high:
        return Colors.red; // Example color for high priority
      case Priority.all:
        return Colors.lightBlue; // Example color for all priority
      default:
        return Colors.transparent;
    }
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      priority: Priority.values[map['priority'] as int],
      isCompleted: map['isCompleted'] as int == 1,
      reminder: map['reminder'] != null
          ? DateTime.parse(map['reminder'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority.index, // Store priority as integer index
        'isCompleted': isCompleted ? 1 : 0,
        'reminder': reminder?.toIso8601String(),
      };
}

enum Priority { high, medium, low, all }
