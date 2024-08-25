class CommentModel {
  final String? id;
  final String taskId;
  final String content;
  final String postedAt;

  CommentModel({
    this.id,
    required this.taskId,
    required this.content,
    required this.postedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      taskId: json['task_id'] ?? '',
      content: json['content'] ?? '',
      postedAt: json['posted_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'content': content,
    };
  }

  CommentModel copyWith({
    String? id,
    String? taskId,
    String? content,
    String? postedAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      content: content ?? this.content,
      postedAt: postedAt ?? this.postedAt,
    );
  }
}
