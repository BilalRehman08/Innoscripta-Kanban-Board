import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';

class CompletedTaskCard extends StatelessWidget {
  final TaskModel task;
  final String priorityLabel;
  final Color priorityColor;
  final String formattedDuration;

  const CompletedTaskCard({
    super.key,
    required this.task,
    required this.priorityLabel,
    required this.priorityColor,
    required this.formattedDuration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: colorScheme.shadow.withOpacity(0.2),
      color: colorScheme.surface,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          collapsedBackgroundColor: colorScheme.surface,
          childrenPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: priorityColor.withOpacity(0.2),
            child: Text(
              priorityLabel[0],
              style: TextStyle(
                color: priorityColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          title: Text(
            task.content ?? 'No title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                Icon(Icons.access_time,
                    size: 14, color: colorScheme.onSurface.withOpacity(0.6)),
                const SizedBox(width: 4),
                Text(
                  formattedDuration,
                  style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 12),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: priorityColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    priorityLabel,
                    style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
           
              ],
            ),
          ),
          children: [
            Container(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (task.description != null &&
                      task.description!.isNotEmpty) ...[
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description!,
                      style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant.withOpacity(0.8)),
                    ),
                    const SizedBox(height: 12),
                  ],
                  _buildInfoRow(context, Icons.folder, 'Project',
                      task.projectId ?? 'Unknown'),
                  const SizedBox(height: 4),
                  _buildInfoRow(context, Icons.calendar_today, 'Created',
                      _formatDate(task.createdAt)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon,
            size: 16, color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                color: colorScheme.onSurfaceVariant.withOpacity(0.8),
                fontSize: 12),
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
