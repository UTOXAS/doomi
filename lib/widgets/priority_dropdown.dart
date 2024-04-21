import 'package:doomi/model/task.dart';
import 'package:flutter/material.dart';

class PriorityDropdown extends StatelessWidget {
  final Priority selectedPriority;
  final Function(Priority) onPriorityChanged;

  const PriorityDropdown({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: DropdownButton<Priority>(
        icon: Container(),
        isExpanded: true,
        value: selectedPriority,
        onChanged: (Priority? priority) {
          onPriorityChanged(priority!);
        },
        underline: Container(),
        items: <Priority>[
          Priority.low,
          Priority.medium,
          Priority.high,
          Priority.all,
        ].map<DropdownMenuItem<Priority>>((Priority priority) {
          String priorityText = priority.toString().split('.').last;
          return DropdownMenuItem<Priority>(
            value: priority,
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Task.getColorForPriority(priority),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(priorityText),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
