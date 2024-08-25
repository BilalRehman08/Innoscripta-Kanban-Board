import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';
import 'package:kanban_board_innoscripta/utils/color_utility.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    required this.onUpdate,
    required this.onDelete,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: ColorUtility.getColorFromString(project.color!).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project.name ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'update') {
                        onUpdate();
                      } else if (value == 'delete') {
                        onDelete();
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'update',
                        child: Text('Update'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ID: ${project.id}'),
                  IconButton(
                    icon: Icon(
                      (project.isFavorite ?? false)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: (project.isFavorite ?? false) ? Colors.red : null,
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
