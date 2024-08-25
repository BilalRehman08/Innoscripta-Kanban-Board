import 'package:kanban_board_innoscripta/app/app.dialogs.dart';
import 'package:kanban_board_innoscripta/app/app.locator.dart';
import 'package:kanban_board_innoscripta/app/app.router.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';

class ProjectsViewModel extends BaseViewModel {
  final ProjectsService projectsService;
  final DialogService dialogService;
  final NavigationService navigationService;
  final ApiRepository apiRepository;
  final SnackbarService snackbarService;

  ProjectsViewModel({
    ProjectsService? projectsService,
    SnackbarService? snackbarService,
    NavigationService? navigationService,
    ApiRepository? apiRepository,
    DialogService? dialogService,
  })  : projectsService = projectsService ?? locator<ProjectsService>(),
        snackbarService = snackbarService ?? locator<SnackbarService>(),
        navigationService = navigationService ?? locator<NavigationService>(),
        dialogService = dialogService ?? locator<DialogService>(),
        apiRepository = apiRepository ?? ApiRepository();

  List<ProjectModel> get projects => projectsService.projects;

  void navigateToProject(String projectId) {
    navigationService.navigateTo(Routes.tasksView,
        arguments: TasksViewArguments(projectId: projectId));
  }

  Future<void> createOrUpdateProject({ProjectModel? project}) async {
    final result = await dialogService.showCustomDialog(
      variant: DialogType.projectForm,
      data: {
        'initialName': project?.name,
        'initialColor': project?.color,
        'projectId': project?.id,
      },
    );

    if (result?.confirmed == true) {
      projectsService.projects = await apiRepository.getProjects();
      snackbarService.showSnackbar(
        message: 'Project saved successfully.',
        duration: const Duration(seconds: 2),
      );
      notifyListeners();
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      await apiRepository.deleteProject(projectId);
      snackbarService.showSnackbar(
        message: 'Project deleted successfully.',
        duration: const Duration(seconds: 2),
      );
      projectsService.deleteProject(projectId);
    } catch (e) {
      snackbarService.showSnackbar(
        message: 'Failed to delete project: $e',
        duration: const Duration(seconds: 2),
      );
    }
    rebuildUi();
  }

  Future<void> toggleFavorite(ProjectModel project) async {
    try {
      // Toggle the favorite status
      project.isFavorite = !(project.isFavorite!);
      rebuildUi();

      await apiRepository.updateProject(project);

      snackbarService.showSnackbar(
        message: project.isFavorite!
            ? 'Project added to favorites.'
            : 'Project removed from favorites.',
        duration: const Duration(seconds: 2),
      );

      // // Refresh the projects list
      // projectsService.projects = await apiRepository.getProjects();
      // notifyListeners();
    } catch (e) {
      snackbarService.showSnackbar(
        message: 'Failed to update favorite status: $e',
        duration: const Duration(seconds: 2),
      );
      // Revert the local change if API update fails
      project.isFavorite = !project.isFavorite!;
      notifyListeners();
    }
  }

  void navigateToFavoriteProjects() async {
    await navigationService.navigateTo(Routes.favoriteProjectsView);
    rebuildUi();
  }
}
