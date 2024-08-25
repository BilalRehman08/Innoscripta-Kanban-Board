import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board_innoscripta/ui/views/favorite_project/favorite_project_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';
import 'package:get_it/get_it.dart';

import 'favorite_project_viewmodel_test.mocks.dart';

@GenerateMocks([ProjectsService])
void main() {
  late FavoriteProjectsViewModel viewModel;
  late MockProjectsService mockProjectsService;
  final getIt = GetIt.instance;

  setUp(() {
    mockProjectsService = MockProjectsService();

    // Register the mock service with GetIt
    getIt.registerSingleton<ProjectsService>(mockProjectsService);

    viewModel = FavoriteProjectsViewModel();
  });

  tearDown(() {
    // Reset GetIt to avoid conflicts between tests
    getIt.reset();
  });

  group('FavoriteProjectsViewModel Tests', () {
    test('favoriteProjects should return only favorite projects', () {
      final mockProjects = [
        ProjectModel(id: '1', name: 'Project 1', isFavorite: true),
        ProjectModel(id: '2', name: 'Project 2', isFavorite: false),
        ProjectModel(id: '3', name: 'Project 3', isFavorite: true),
      ];

      when(mockProjectsService.projects).thenReturn(mockProjects);

      final favoriteProjects = viewModel.favoriteProjects;

      expect(favoriteProjects.length, 2);
      expect(favoriteProjects, contains(mockProjects[0]));
      expect(favoriteProjects, contains(mockProjects[2]));
    });

    test('refreshProjects should notify listeners', () {
      var notified = false;

      viewModel.addListener(() {
        notified = true;
      });

      viewModel.refreshProjects();

      expect(notified, isTrue);
    });
  });
}
