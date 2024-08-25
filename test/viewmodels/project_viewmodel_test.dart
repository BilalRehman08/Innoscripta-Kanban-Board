import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board_innoscripta/app/app.dialogs.dart';
import 'package:kanban_board_innoscripta/app/app.router.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:kanban_board_innoscripta/ui/views/projects/projects_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import 'project_viewmodel_test.mocks.dart';

@GenerateMocks([
  ProjectsService,
  SnackbarService,
  NavigationService,
  DialogService,
  ApiRepository
])
void main() {
  late MockProjectsService mockProjectsService;
  late MockSnackbarService mockSnackbarService;
  late MockNavigationService mockNavigationService;
  late MockDialogService mockDialogService;
  late MockApiRepository mockApiRepository;
  late ProjectsViewModel viewModel;

  setUp(() {
    mockProjectsService = MockProjectsService();
    mockSnackbarService = MockSnackbarService();
    mockNavigationService = MockNavigationService();
    mockDialogService = MockDialogService();
    mockApiRepository = MockApiRepository();

    viewModel = ProjectsViewModel(
      projectsService: mockProjectsService,
      snackbarService: mockSnackbarService,
      navigationService: mockNavigationService,
      dialogService: mockDialogService,
      apiRepository: mockApiRepository,
    );
  });

  group('ProjectsViewModel Tests - ', () {
    test('Projects getter returns projects from ProjectsService', () {
      final projectList = [ProjectModel(id: '1', name: 'Test Project')];
      when(mockProjectsService.projects).thenReturn(projectList);

      expect(viewModel.projects, projectList);
    });

    test(
        'navigateToProject should navigate to the correct route with arguments',
        () async {
      const projectId = '1';

      // Stubbing navigateTo method to return a Future with a value.
      when(mockNavigationService.navigateTo(
        Routes.tasksView,
        arguments: anyNamed('arguments'),
      )).thenAnswer((_) async => Future.value());

      viewModel.navigateToProject(projectId);

      verify(mockNavigationService.navigateTo(
        Routes.tasksView,
        arguments: anyNamed('arguments'),
      )).called(1);
    });

    test(
        'createOrUpdateProject should update projects and show success snackbar',
        () async {
      final result = DialogResponse(confirmed: true);
      when(mockDialogService.showCustomDialog(
        variant: DialogType.projectForm,
        data: anyNamed('data'),
      )).thenAnswer((_) async => result);
      when(mockApiRepository.getProjects()).thenAnswer(
          (_) async => [ProjectModel(id: '1', name: 'New Project')]);

      await viewModel.createOrUpdateProject();

      verify(mockApiRepository.getProjects()).called(1);
      verify(mockSnackbarService.showSnackbar(
        message: 'Project saved successfully.',
        duration: anyNamed('duration'),
      )).called(1);
    });

    test('deleteProject should delete project and show success snackbar',
        () async {
      const projectId = '1';
      when(mockApiRepository.deleteProject(projectId))
          .thenAnswer((_) async => Future.value());

      await viewModel.deleteProject(projectId);

      verify(mockApiRepository.deleteProject(projectId)).called(1);
      verify(mockSnackbarService.showSnackbar(
        message: 'Project deleted successfully.',
        duration: anyNamed('duration'),
      )).called(1);
      verify(mockProjectsService.deleteProject(projectId)).called(1);
    });

    test('navigateToFavoriteProjects should navigate to favorite projects view',
        () async {
      // Stubbing navigateTo method to return a Future with a value.
      when(mockNavigationService.navigateTo(Routes.favoriteProjectsView))
          .thenAnswer((_) async => Future.value());

      viewModel.navigateToFavoriteProjects();

      verify(mockNavigationService.navigateTo(Routes.favoriteProjectsView))
          .called(1);
    });
  });
}
