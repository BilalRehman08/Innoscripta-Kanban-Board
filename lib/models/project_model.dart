class ProjectModel {
  String? id;
  String? parentId;
  int? order;
  String? color;
  String? name;
  int? commentCount;
  bool? isShared;
  bool? isFavorite;
  bool? isInboxProject;
  bool? isTeamInbox;
  String? url;
  String? viewStyle;

  ProjectModel(
      {this.id,
      this.parentId,
      this.order,
      this.color,
      this.name,
      this.commentCount,
      this.isShared,
      this.isFavorite,
      this.isInboxProject,
      this.isTeamInbox,
      this.url,
      this.viewStyle});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    order = json['order'];
    color = json['color'];
    name = json['name'];
    commentCount = json['comment_count'];
    isShared = json['is_shared'];
    isFavorite = json['is_favorite'];
    isInboxProject = json['is_inbox_project'];
    isTeamInbox = json['is_team_inbox'];
    url = json['url'];
    viewStyle = json['view_style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['order'] = order;
    data['color'] = color;
    data['name'] = name;
    data['comment_count'] = commentCount;
    data['is_shared'] = isShared;
    data['is_favorite'] = isFavorite;
    data['is_inbox_project'] = isInboxProject;
    data['is_team_inbox'] = isTeamInbox;
    data['url'] = url;
    data['view_style'] = viewStyle;
    return data;
  }
}
