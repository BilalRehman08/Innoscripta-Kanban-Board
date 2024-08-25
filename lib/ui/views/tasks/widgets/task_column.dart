import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:kanban_board_innoscripta/ui/views/tasks/widgets/task_card.dart';

class TaskColumn extends StatelessWidget {
  final String title;
  final List<TaskModel> tasks;
  final Function(TaskModel, String) onMoveTask;
  final Function(TaskModel) onToggleTimer;
  final Function(TaskModel) onMarkCompleted;
  final Function(TaskModel) onShowDetails;
  final String Function(TaskModel) getFormattedDuration;
  final bool Function(TaskModel) isTimerRunning;

  const TaskColumn({
    super.key,
    required this.title,
    required this.tasks,
    required this.onMoveTask,
    required this.onToggleTimer,
    required this.onMarkCompleted,
    required this.onShowDetails,
    required this.getFormattedDuration,
    required this.isTimerRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Expanded(
            child: DragTarget<TaskModel>(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return LongPressDraggable<TaskModel>(
                      delay: const Duration(milliseconds: 200),
                      data: task,
                      feedback: Material(
                        elevation: 4.0,
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.white,
                          child: Text(task.content ?? ''),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: TaskCard(
                          task: task,
                          columnTitle: title,
                          onToggleTimer: onToggleTimer,
                          onMarkCompleted: onMarkCompleted,
                          onShowDetails: onShowDetails,
                          getFormattedDuration: getFormattedDuration,
                          isTimerRunning: isTimerRunning,
                        ),
                      ),
                      child: TaskCard(
                        task: task,
                        columnTitle: title,
                        onToggleTimer: onToggleTimer,
                        onMarkCompleted: onMarkCompleted,
                        onShowDetails: onShowDetails,
                        getFormattedDuration: getFormattedDuration,
                        isTimerRunning: isTimerRunning,
                      ),
                    );
                  },
                );
              },
              onAcceptWithDetails: (details) {
                onMoveTask(details.data, title);
              },
            ),
          ),
        ],
      ),
    );
  }
}
