import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/views/comments/widgets/comment_input.dart';
import 'package:kanban_board_innoscripta/ui/views/comments/widgets/comment_item.dart';
import 'package:stacked/stacked.dart';
import 'comments_viewmodel.dart';

class CommentsView extends StackedView<CommentsViewModel> {
  final String taskId;

  const CommentsView({super.key, required this.taskId});

  @override
  Widget builder(
      BuildContext context, CommentsViewModel viewModel, Widget? child) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: Container(
        color: colorScheme.surface,
        child: Column(
          children: [
            Expanded(
              child: _buildCommentsList(viewModel, colorScheme),
            ),
            CommentInput(
              controller: viewModel.commentController,
              onSend: viewModel.addComment,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsList(
      CommentsViewModel viewModel, ColorScheme colorScheme) {
    if (viewModel.isBusy) {
      return Center(
          child: CircularProgressIndicator(color: colorScheme.primary));
    }

    return ListView.separated(
      itemCount: viewModel.comments.length,
      separatorBuilder: (context, index) =>
          Divider(color: colorScheme.outline.withOpacity(0.2)),
      itemBuilder: (context, index) {
        final comment = viewModel.comments[index];
        return CommentItem(
          comment: comment,
          onDelete: viewModel.deleteComment,
          onEdit: viewModel.updateComment,
        );
      },
    );
  }

  @override
  CommentsViewModel viewModelBuilder(BuildContext context) =>
      CommentsViewModel(taskId);

  @override
  void onViewModelReady(CommentsViewModel viewModel) => viewModel.initialize();
}
