import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:kanban_board_innoscripta/models/comment_model.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';

class CommentsViewModel extends BaseViewModel {
  final String taskId;
  final commentController = TextEditingController();
  List<CommentModel> _comments = [];
  final ApiRepository apiRepository;

  CommentsViewModel(this.taskId, {ApiRepository? apiRepository})
      : apiRepository = apiRepository ?? ApiRepository();

  List<CommentModel> get comments => _comments;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> initialize() async {
    await fetchComments();
  }

  Future<void> fetchComments() async {
    setBusy(true);
    try {
      _comments = await apiRepository.getComments(taskId);
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }

  Future<void> addComment() async {
    if (commentController.text.isEmpty) return;

    setBusy(true);
    try {
      final newComment =
          await apiRepository.addComment(taskId, commentController.text);
      _comments.add(newComment);
      commentController.clear();
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateComment(String commentId, String newContent) async {
    setBusy(true);
    try {
      await apiRepository.updateComment(commentId, newContent);
      final index = _comments.indexWhere((comment) => comment.id == commentId);
      if (index != -1) {
        _comments[index] = _comments[index].copyWith(content: newContent);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteComment(String commentId) async {
    setBusy(true);
    try {
      await apiRepository.deleteComment(commentId);
      _comments.removeWhere((comment) => comment.id == commentId);
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }
}
