import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kanban_board_innoscripta/models/comment_model.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final Function(String) onDelete;
  final Function(String, String) onEdit;

  const CommentItem({
    super.key,
    required this.comment,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: Key(comment.id!),
      background: Container(
        color: colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(comment.id!),
      child: Card(
        elevation: 0,
        color: colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM d, y HH:mm')
                        .format(DateTime.parse(comment.postedAt)),
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.edit, size: 18, color: colorScheme.primary),
                    onPressed: () => _showEditCommentDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                comment.content,
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditCommentDialog(BuildContext context) {
    final editController = TextEditingController(text: comment.content);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Comment',
            style: TextStyle(color: colorScheme.onSurface)),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(
            hintText: 'Edit your comment',
            hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          style: TextStyle(color: colorScheme.onSurface),
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: colorScheme.primary)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            onPressed: () {
              onEdit(comment.id!, editController.text);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: const Text('Save'),
          ),
        ],
        backgroundColor: colorScheme.surface,
      ),
    );
  }
}
