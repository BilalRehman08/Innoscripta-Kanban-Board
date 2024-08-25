import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';

class UpdateTaskViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final String projectId;
  final String? taskId;
  String? label;
  final ApiRepository apiRepository;

  UpdateTaskViewModel(this.projectId, this.taskId,
      {ApiRepository? apiRepository})
      : apiRepository = apiRepository ?? ApiRepository();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int _priority = 1;
  DateTime? _dueDate;
  String? _titleError;
  String? _descriptionError;

  int get priority => _priority;
  DateTime? get dueDate => _dueDate;
  String? get titleError => _titleError;
  String? get descriptionError => _descriptionError;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> initialize() async {
    if (taskId != null) {
      setBusy(true);
      try {
        final task = await apiRepository.getTask(taskId!);
        titleController.text = task.content ?? '';
        label = task.labels?.first;
        descriptionController.text = task.description ?? '';
        _priority = task.priority ?? 1;
        _dueDate =
            task.due?.date != null ? DateTime.parse(task.due!.date!) : null;
      } catch (e) {
        // Handle error
      } finally {
        setBusy(false);
      }
    }
  }

  void setPriority(int? value) {
    if (value != null) {
      _priority = value;
      notifyListeners();
    }
  }

  Future<void> selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _dueDate) {
      _dueDate = picked;
      notifyListeners();
    }
  }

  String getPriorityLabel(int priority) {
    switch (priority) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      case 4:
        return 'Urgent';
      default:
        return 'Unknown';
    }
  }

  Future<void> saveTask() async {
    _titleError = null;
    _descriptionError = null;
    bool hasError = false;

    if (titleController.text.isEmpty) {
      _titleError = 'Title field cannot be empty';
      hasError = true;
    }

    if (descriptionController.text.isEmpty) {
      _descriptionError = 'Description field cannot be empty';
      hasError = true;
    }

    if (hasError) {
      notifyListeners();
      return;
    }

    setBusy(true);
    try {
      final task = TaskModel(
        id: taskId,
        content: titleController.text,
        description: descriptionController.text,
        projectId: projectId,
        priority: _priority,
        labels: taskId == null ? ['todo'] : [label!],
        dueDate: _dueDate != null
            ? DateFormat('yyyy-MM-dd').format(_dueDate!)
            : null,
      );

      if (taskId == null) {
        var result = await apiRepository.createTask(task);
        print(result);
      } else {
        var result = await apiRepository.updateTask(taskId!, task);
        print(result);
      }

      _navigationService.back(result: true);
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteTask(BuildContext context) async {
    if (taskId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed == true) {
      setBusy(true);
      try {
        await apiRepository.deleteTask(taskId!);
        _navigationService.back(result: true);
      } catch (e) {
        // Handle error
      } finally {
        setBusy(false);
      }
    }
  }
}
