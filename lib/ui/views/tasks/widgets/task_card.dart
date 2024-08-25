import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:kanban_board_innoscripta/utils/priority_utility.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final String columnTitle;
  final Function(TaskModel) onToggleTimer;
  final Function(TaskModel) onMarkCompleted;
  final Function(TaskModel) onShowDetails;
  final String Function(TaskModel) getFormattedDuration;
  final bool Function(TaskModel) isTimerRunning;

  const TaskCard({
    super.key,
    required this.task,
    required this.columnTitle,
    required this.onToggleTimer,
    required this.onMarkCompleted,
    required this.onShowDetails,
    required this.getFormattedDuration,
    required this.isTimerRunning,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => onShowDetails(task),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: PriorityUtility.getPriorityColor(task.priority!)
                  .withOpacity(0.8),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: PriorityUtility.getPriorityColor(task.priority!)
                      .withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task.content ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildActionButton(colorScheme),
                  ],
                ),
              ),
              if (task.description != "")
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    task.description!,
                    style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.7)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const SizedBox(height: 8),
              if (columnTitle == 'In Progress')
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getFormattedDuration(task),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      _buildTimerButton(colorScheme),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerButton(ColorScheme colorScheme) {
    return InkWell(
      onTap: () => onToggleTimer(task),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isTimerRunning(task) ? colorScheme.error : colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isTimerRunning(task) ? Icons.stop : Icons.play_arrow,
          color: colorScheme.onPrimary,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildActionButton(ColorScheme colorScheme) {
    if (columnTitle == 'Done') {
      return Tooltip(
        message: 'Mark as Completed',
        child: InkWell(
          onTap: () => onMarkCompleted(task),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline_outlined,
              color: colorScheme.onPrimary,
              size: 18,
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
