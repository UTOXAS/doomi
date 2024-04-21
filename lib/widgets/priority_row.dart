import 'package:doomi/model/task.dart';
import 'package:flutter/material.dart';

class PriorityRow extends StatefulWidget {
  final Priority selectedPriority;
  final Function(Priority) onPriorityChanged;
  const PriorityRow({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  State<PriorityRow> createState() => _PriorityRowState();
}

class _PriorityRowState extends State<PriorityRow> {
  Priority _currentSelected = Priority.low;

  @override
  void initState() {
    super.initState();
    _currentSelected = widget.selectedPriority;
  }

  void _handlePriorityClick(Priority priority) {
    setState(() {
      _currentSelected = priority;
      widget.onPriorityChanged(priority);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = Priority.values.length - 1; i >= 0; i--) ...[
            Expanded(
              child: GestureDetector(
                onTap: () => _handlePriorityClick(Priority.values[i]),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Task.getColorForPriority(Priority.values[i])
                        .withAlpha(_currentSelected == Priority.values[i]
                            ? 250
                            : 100), // Consistent background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(Priority.values[i].toString().split('.').last),
                  ),
                ),
              ),
            ),
            if (i > 0) // Add spacer after all except last
              const SizedBox(width: 5.0), // Adjust spacing as needed
          ],
        ]);
  }
}
