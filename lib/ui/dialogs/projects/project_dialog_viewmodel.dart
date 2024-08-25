import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:stacked/stacked.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';

class ProjectFormDialogViewModel extends BaseViewModel {
  final TextEditingController nameController;
  String selectedColor;
  final List<String> colors = ['red', 'blue', 'orange', 'green', 'violet'];
  final String? projectId;
  final ApiRepository apiRepository;

  ProjectFormDialogViewModel({
    String? initialName,
    String? initialColor,
    this.projectId,
    ApiRepository? apiRepository,
  })  : nameController = TextEditingController(text: initialName),
        selectedColor = initialColor ?? 'red',
        apiRepository = apiRepository ?? ApiRepository();

  void setColor(String color) {
    selectedColor = color;
    notifyListeners();
  }

  Future<ProjectModel> saveProject() async {
    final project = ProjectModel(
      id: projectId,
      name: nameController.text,
      color: selectedColor,
    );

    if (projectId == null) {
      return await apiRepository.createProject(project);
    } else {
      return await apiRepository.updateProject(project);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
