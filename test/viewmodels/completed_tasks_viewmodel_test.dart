import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board_innoscripta/ui/views/completed_tasks/completed_task_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';
import 'package:kanban_board_innoscripta/services/local_storage_service.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:get_it/get_it.dart';

import 'completed_tasks_viewmodel_test.mocks.dart';

@GenerateMocks([LocalStorageService, ProjectsService])
void main() {
  late CompletedTasksViewModel viewModel;
  late MockLocalStorageService mockLocalStorageService;
  late MockProjectsService mockProjectsService;
  final getIt = GetIt.instance;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    mockProjectsService = MockProjectsService();

    // Register the mock services with GetIt
    getIt.registerSingleton<LocalStorageService>(mockLocalStorageService);
    getIt.registerSingleton<ProjectsService>(mockProjectsService);

    viewModel = CompletedTasksViewModel();
  });

  tearDown(() {
    getIt.reset();
  });

  test('initialize should fetch completed tasks and project names', () async {
    final mockTasks = [
      TaskModel(id: '1', projectId: 'p1'),
      TaskModel(id: '2', projectId: 'p2'),
    ];

    final mockProjects = [
      ProjectModel(id: 'p1', name: 'Project 1'),
      ProjectModel(id: 'p2', name: 'Project 2'),
    ];

    when(mockLocalStorageService.getCompletedTasks()).thenReturn(mockTasks);
    when(mockProjectsService.projects).thenReturn(mockProjects);

    await viewModel.initialize();

    expect(viewModel.completedTasksByProject.length, 2);
    expect(viewModel.projectNames['p1'], 'Project 1');
    expect(viewModel.projectNames['p2'], 'Project 2');
  });

  test('fetchCompletedTasks should group tasks by project', () async {
    final mockTasks = [
      TaskModel(id: '1', projectId: 'p1'),
      TaskModel(id: '2', projectId: 'p1'),
      TaskModel(id: '3', projectId: 'p2'),
    ];

    when(mockLocalStorageService.getCompletedTasks()).thenReturn(mockTasks);

    await viewModel.fetchCompletedTasks();

    expect(viewModel.completedTasksByProject['p1']!.length, 2);
    expect(viewModel.completedTasksByProject['p2']!.length, 1);
  });

  test('getPriorityLabel should return correct label for priority', () {
    expect(viewModel.getPriorityLabel(1), 'Low');
    expect(viewModel.getPriorityLabel(2), 'Medium');
    expect(viewModel.getPriorityLabel(3), 'High');
  });

  test('getProjectName should return correct project name or default value',
      () {
    viewModel.projectNames['p1'] = 'Test Project';
    expect(viewModel.getProjectName('p1'), 'Test Project');
    expect(viewModel.getProjectName('p2'), 'Unknown Project');
  });

  test('getProjectColor should return correct project color or default value',
      () {
    final mockProjects = [
      ProjectModel(id: 'p1', color: '0xFF00FF00'),
    ];

    when(mockProjectsService.projects).thenReturn(mockProjects);

    expect(viewModel.getProjectColor('p1'), '0xFF00FF00');
    expect(viewModel.getProjectColor('p2'), '0xFF000000');
  });
}
