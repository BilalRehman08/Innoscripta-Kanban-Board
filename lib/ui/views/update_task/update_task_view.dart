import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/views/update_task/update_task_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class UpdateTaskView extends StackedView<UpdateTaskViewModel> {
  final String projectId;
  final String? taskId;

  const UpdateTaskView({super.key, required this.projectId, this.taskId});

  @override
  Widget builder(
      BuildContext context, UpdateTaskViewModel viewModel, Widget? child) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(taskId == null ? 'Create Task' : 'Edit Task'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          if (taskId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => viewModel.deleteTask(context),
              tooltip: 'Delete Task',
            ),
        ],
      ),
      body: viewModel.isBusy
          ? Center(child: CircularProgressIndicator(color: colorScheme.primary))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    context: context,
                    controller: viewModel.titleController,
                    label: 'Task Title',
                    errorText: viewModel.titleError,
                    icon: Icons.title,
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    context: context,
                    controller: viewModel.descriptionController,
                    label: 'Description',
                    errorText: viewModel.descriptionError,
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  _buildPriorityDropdown(context, viewModel),
                  const SizedBox(height: 24),
                  _buildDatePicker(context, viewModel),
                  const SizedBox(height: 32),
                  _buildSaveButton(context, viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? errorText,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
      ),
      maxLines: maxLines,
      style: TextStyle(color: colorScheme.onSurface),
    );
  }

  Widget _buildPriorityDropdown(
      BuildContext context, UpdateTaskViewModel viewModel) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButtonFormField<int>(
      value: viewModel.priority,
      decoration: InputDecoration(
        labelText: 'Priority',
        prefixIcon: Icon(Icons.flag, color: colorScheme.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
      ),
      items: [1, 2, 3, 4].map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(
            viewModel.getPriorityLabel(value),
            style: TextStyle(color: colorScheme.onSurface),
          ),
        );
      }).toList(),
      onChanged: viewModel.setPriority,
      dropdownColor: colorScheme.surface,
    );
  }

  Widget _buildDatePicker(BuildContext context, UpdateTaskViewModel viewModel) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => viewModel.selectDueDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Due Date',
          prefixIcon: Icon(Icons.calendar_today, color: colorScheme.primary),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          filled: true,
          fillColor: colorScheme.surface,
        ),
        child: Text(
          viewModel.dueDate != null
              ? DateFormat('yyyy-MM-dd').format(viewModel.dueDate!)
              : 'Select Due Date',
          style: TextStyle(color: colorScheme.onSurface),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, UpdateTaskViewModel viewModel) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton.icon(
      onPressed: viewModel.saveTask,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(taskId == null ? Icons.add_task : Icons.save),
      label: Text(
        taskId == null ? 'Create Task' : 'Update Task',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  UpdateTaskViewModel viewModelBuilder(BuildContext context) =>
      UpdateTaskViewModel(projectId, taskId);

  @override
  void onViewModelReady(UpdateTaskViewModel viewModel) =>
      viewModel.initialize();
}
