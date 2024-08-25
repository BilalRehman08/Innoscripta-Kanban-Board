import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/bottom_sheets/task_detail/task_detail_sheet_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:kanban_board_innoscripta/utils/date_formatter_utility.dart';
import 'package:kanban_board_innoscripta/utils/priority_utility.dart';

class TaskDetailsSheet extends StackedView<TaskDetailsSheetViewModel> {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const TaskDetailsSheet({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(BuildContext context, TaskDetailsSheetViewModel viewModel,
      Widget? child) {
    final task = request.data as TaskModel;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, task),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (task.description != "") ...[
                      _buildDescription(context, task),
                      const SizedBox(height: 24),
                    ],
                    _buildInfoRows(context, task),
                    const SizedBox(height: 24),
                    _buildCommentsButton(viewModel, task, context),
                    const SizedBox(height: 24),
                    _buildEditButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TaskModel task) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.content ?? 'No Title',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              _buildPriorityChip(context, task.priority),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Task ID: ${task.id}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, TaskModel task) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Text(
        task.description ?? 'No description',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
      ),
    );
  }

  Widget _buildInfoRows(BuildContext context, TaskModel task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          infoRowWidget(
            context,
            icon: Icons.calendar_today,
            label: 'Created',
            value: DateFormatterUtility.formatDate(task.createdAt),
          ),
          const Divider(height: 16),
          infoRowWidget(
            context,
            icon: Icons.event,
            label: 'Due',
            value: DateFormatterUtility.formatDate(task.due?.date),
          ),
          const Divider(height: 16),
          infoRowWidget(
            context,
            icon: Icons.timer,
            label: 'Time spent',
            value: DateFormatterUtility.formatDuration(task.duration ?? 0),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsButton(TaskDetailsSheetViewModel viewModel,
      TaskModel task, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton.icon(
      onPressed: () => viewModel.previewComments(task),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      icon: const Icon(Icons.comment),
      label: const Text('View Comments'),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => completer(SheetResponse(confirmed: true)),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        icon: const Icon(Icons.edit),
        label: const Text('Edit Task', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildPriorityChip(BuildContext context, int? priority) {
    final priorityColor = PriorityUtility.getPriorityColor(priority);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: priorityColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: priorityColor),
      ),
      child: Text(
        PriorityUtility.getPriorityString(priority),
        style: TextStyle(
          color: priorityColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget infoRowWidget(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  TaskDetailsSheetViewModel viewModelBuilder(BuildContext context) =>
      TaskDetailsSheetViewModel();
}
