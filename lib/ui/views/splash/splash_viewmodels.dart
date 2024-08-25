import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/local_storage_service.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  ProjectsService projectsService = locator<ProjectsService>();
  ApiRepository apiRepository = ApiRepository();

  Future<void> initialize() async {
    await locator<LocalStorageService>().init();

    setBusy(true);

    final projects = await apiRepository.getProjects();
    projectsService.projects = projects;
    notifyListeners();

    setBusy(false);

    await _navigationService.replaceWith(Routes.projectsView);
  }
}
