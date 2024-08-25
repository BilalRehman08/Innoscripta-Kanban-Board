import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/views/tasks/tasks_viewmodel.dart';
import 'package:kanban_board_innoscripta/ui/views/tasks/widgets/task_column.dart';
import 'package:stacked/stacked.dart';

class TasksView extends StackedView<TasksViewModel> {
  final String projectId;

  const TasksView({super.key, required this.projectId});

  @override
  Widget builder(
      BuildContext context, TasksViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.project.name ?? ''),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: viewModel.navigateToCompletedTasks,
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                TaskColumn(
                  title: 'To Do',
                  tasks: viewModel.todoTasks,
                  onMoveTask: viewModel.moveTask,
                  onToggleTimer: viewModel.toggleTimer,
                  onMarkCompleted: viewModel.markTaskAsCompleted,
                  onShowDetails: viewModel.showTaskDetails,
                  getFormattedDuration: viewModel.getFormattedDuration,
                  isTimerRunning: viewModel.isTimerRunning,
                ),
                TaskColumn(
                  title: 'In Progress',
                  tasks: viewModel.inProgressTasks,
                  onMoveTask: viewModel.moveTask,
                  onToggleTimer: viewModel.toggleTimer,
                  onMarkCompleted: viewModel.markTaskAsCompleted,
                  onShowDetails: viewModel.showTaskDetails,
                  getFormattedDuration: viewModel.getFormattedDuration,
                  isTimerRunning: viewModel.isTimerRunning,
                ),
                TaskColumn(
                  title: 'Done',
                  tasks: viewModel.doneTasks,
                  onMoveTask: viewModel.moveTask,
                  onToggleTimer: viewModel.toggleTimer,
                  onMarkCompleted: viewModel.markTaskAsCompleted,
                  onShowDetails: viewModel.showTaskDetails,
                  getFormattedDuration: viewModel.getFormattedDuration,
                  isTimerRunning: viewModel.isTimerRunning,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  TasksViewModel viewModelBuilder(BuildContext context) => TasksViewModel();

  @override
  void onViewModelReady(TasksViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initialize();
  }
}
