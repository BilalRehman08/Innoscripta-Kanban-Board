import 'package:stacked/stacked.dart';
import 'package:kanban_board_innoscripta/app/app.locator.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';

class FavoriteProjectsViewModel extends BaseViewModel {
  final ProjectsService _projectsService = locator<ProjectsService>();

  List<ProjectModel> get favoriteProjects => _projectsService.projects
      .where((project) => project.isFavorite!)
      .toList();

  void refreshProjects() {
    notifyListeners();
  }

  void toggleFavorite(ProjectModel project) {
    project.isFavorite = !project.isFavorite!;
    _projectsService.updateProject(project);
    notifyListeners();
  }
}
