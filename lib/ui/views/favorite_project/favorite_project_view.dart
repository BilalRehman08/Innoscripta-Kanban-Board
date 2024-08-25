import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/views/favorite_project/favorite_project_viewmodel.dart';
import 'package:kanban_board_innoscripta/utils/color_utility.dart';
import 'package:stacked/stacked.dart';

class FavoriteProjectsView extends StackedView<FavoriteProjectsViewModel> {
  const FavoriteProjectsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    FavoriteProjectsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Projects'),
        elevation: 0,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.favoriteProjects.isEmpty
              ? const Center(child: Text('No favorite projects yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewModel.favoriteProjects.length,
                  itemBuilder: (context, index) {
                    final project = viewModel.favoriteProjects[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorUtility.getColorFromString(project.color!)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          leading: CircleAvatar(
                            backgroundColor:
                                ColorUtility.getColorFromString(project.color!),
                            child: Text(
                              project.name?[0] ?? 'N',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            project.name ?? 'No title',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(project.id ?? 'No id'),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              viewModel.toggleFavorite(project);
                            },
                          ),
                          onTap: () {
                            // Handle project tap
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  @override
  FavoriteProjectsViewModel viewModelBuilder(BuildContext context) =>
      FavoriteProjectsViewModel();
}
