import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/dialogs/projects/project_dialog_viewmodel.dart';
import 'package:kanban_board_innoscripta/utils/color_utility.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectFormDialog extends StackedView<ProjectFormDialogViewModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ProjectFormDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(BuildContext context, ProjectFormDialogViewModel viewModel,
      Widget? child) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            request.data['initialName'] == null
                ? 'Create Project'
                : 'Update Project',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: viewModel.nameController,
            decoration: InputDecoration(
              labelText: 'Project Name',
              labelStyle: const TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.blueGrey,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  width: 2.0,
                ),
              ),
              prefixIcon: const Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
              filled: true,
              fillColor: Colors.blueGrey.withOpacity(0.1),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Color',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(viewModel.colors.length, (index) {
              final colorName = viewModel.colors[index];
              final color = ColorUtility.getColorFromString(colorName);
              final isSelected = colorName == viewModel.selectedColor;

              return GestureDetector(
                onTap: () => viewModel.setColor(colorName),
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: isSelected ? 15 : 13,
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => completer(DialogResponse(confirmed: false)),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              final project = await viewModel.saveProject();
              completer(DialogResponse(confirmed: true, data: project));
            } catch (e) {
              // Handle error
              completer(DialogResponse(confirmed: false, data: e.toString()));
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  ProjectFormDialogViewModel viewModelBuilder(BuildContext context) =>
      ProjectFormDialogViewModel(
        initialName: request.data['initialName'],
        initialColor: request.data['initialColor'],
        projectId: request.data['projectId'],
      );
}
