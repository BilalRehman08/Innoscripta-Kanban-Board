import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/views/completed_tasks/completed_task_viewmodel.dart';
import 'package:kanban_board_innoscripta/ui/widgets/completed_task_card.dart';
import 'package:kanban_board_innoscripta/utils/color_utility.dart';
import 'package:stacked/stacked.dart';

class CompletedTasksView extends StackedView<CompletedTasksViewModel> {
  const CompletedTasksView({super.key});

  @override
  Widget builder(
      BuildContext context, CompletedTasksViewModel viewModel, Widget? child) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks',
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: Container(
        color: colorScheme.surface,
        child: viewModel.isBusy
            ? Center(
                child: CircularProgressIndicator(color: colorScheme.primary))
            : viewModel.completedTasksByProject.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task_alt,
                            size: 100,
                            color: colorScheme.primary.withOpacity(0.7)),
                        const SizedBox(height: 16),
                        Text(
                          'No completed tasks yet!',
                          style: TextStyle(
                              fontSize: 20, color: colorScheme.onSurface),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Complete a task to see it here.',
                          style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.onSurface.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.completedTasksByProject.length,
                    itemBuilder: (context, index) {
                      final projectId = viewModel.completedTasksByProject.keys
                          .elementAt(index);
                      final projectTasks =
                          viewModel.completedTasksByProject[projectId]!;
                      final projectName = viewModel.getProjectName(projectId);
                      final projectColor = viewModel.getProjectColor(projectId);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        shadowColor: colorScheme.shadow.withOpacity(0.3),
                        color: colorScheme.surface.withOpacity(0.8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  ColorUtility.getColorFromString(projectColor)
                                      .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: Text(projectName,
                                  style: TextStyle(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${projectTasks.length} completed tasks',
                                  style: TextStyle(
                                      color: colorScheme.onSurface
                                          .withOpacity(0.7))),
                              collapsedBackgroundColor:
                                  colorScheme.surface.withOpacity(0.8),
                              backgroundColor: colorScheme
                                  .surfaceContainerHighest
                                  .withOpacity(0.8),
                              children: projectTasks
                                  .map((task) => CompletedTaskCard(
                                        task: task,
                                        priorityLabel:
                                            viewModel.getPriorityLabel(
                                                task.priority ?? 0),
                                        priorityColor:
                                            viewModel.getPriorityColor(
                                                task.priority ?? 0),
                                        formattedDuration:
                                            viewModel.getFormattedDuration(
                                                task.duration ?? 0),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  @override
  CompletedTasksViewModel viewModelBuilder(BuildContext context) =>
      CompletedTasksViewModel();

  @override
  void onViewModelReady(CompletedTasksViewModel viewModel) =>
      viewModel.initialize();
}
