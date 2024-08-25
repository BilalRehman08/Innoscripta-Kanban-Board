import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/views/theme/theme_view.dart';
import 'package:kanban_board_innoscripta/ui/widgets/project_card_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:kanban_board_innoscripta/ui/views/projects/projects_viewmodel.dart';

class ProjectsView extends StackedView<ProjectsViewModel> {
  const ProjectsView({super.key});

  @override
  Widget builder(
      BuildContext context, ProjectsViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: const ThemeView(),
        title: const Text('Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => viewModel.createOrUpdateProject(),
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: viewModel.projects.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                final project = viewModel.projects[index];
                return ProjectCard(
                  project: project,
                  onTap: () {
                    viewModel.projectsService.selectedProject = project;
                    viewModel.navigateToProject(project.id!);
                  },
                  onUpdate: () =>
                      viewModel.createOrUpdateProject(project: project),
                  onDelete: () => viewModel.deleteProject(project.id!),
                  onToggleFavorite: () {
                    viewModel.toggleFavorite(project);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 5),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.navigateToFavoriteProjects();
        },
        child: const Icon(
          Icons.favorite_border_outlined,
        ),
      ),
    );
  }

  @override
  ProjectsViewModel viewModelBuilder(BuildContext context) =>
      ProjectsViewModel();
}
