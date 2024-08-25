import 'package:kanban_board_innoscripta/models/project_model.dart';

class ProjectsService {
  List<ProjectModel> projects = [];
  ProjectModel? selectedProject;

  void deleteProject(String projectId) {
    projects.removeWhere((p) => p.id == projectId);
  }

  void toggleFavorite(String projectId) {
    final project = projects.firstWhere((p) => p.id == projectId);
    project.isFavorite = !project.isFavorite!;
  }

  void updateProject(ProjectModel updatedProject) {
    final index = projects.indexWhere((p) => p.id == updatedProject.id);
    if (index != -1) {
      projects[index] = updatedProject;
    }
  }
}
