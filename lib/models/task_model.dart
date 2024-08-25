class TaskModel {
  String? id;
  String? content;
  int? order;
  int? priority;
  String? description;
  bool? isCompleted;
  String? projectId;
  int? duration;
  String? durationUnit;
  String? createdAt;
  Due? due;
  String? dueDate;
  List<String>? labels;

  TaskModel({
    this.id,
    this.projectId,
    this.order,
    this.content,
    this.description,
    this.isCompleted,
    this.priority,
    this.createdAt,
    this.due,
    this.dueDate,
    this.duration,
    this.durationUnit,
    this.labels, // Make it optional in the constructor
  }); // Initialize with empty list if null

  TaskModel.fromJson(Map<String, dynamic> json)
      : labels = List<String>.from(json['labels'] ?? []) {
    // Initialize labels first
    id = json['id'];
    projectId = json['project_id'];
    order = json['order'];
    content = json['content'];
    description = json['description'];
    isCompleted = json['is_completed'];
    priority = json['priority'];
    createdAt = json['created_at'];
    due = json['due'] != null ? Due.fromJson(json['due']) : null;

    // Handle different types for duration
    if (json['duration'] != null) {
      if (json['duration'] is int) {
        duration = json['duration'];
      } else if (json['duration'] is String) {
        duration = int.tryParse(json['duration']);
      } else if (json['duration'] is Map) {
        duration = int.tryParse(json['duration']['amount']?.toString() ?? '');
      }
    }

    durationUnit = json['duration_unit'];
    // labels is already initialized
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (priority != null) data['priority'] = priority;
    if (order != null) data['order'] = order;
    if (content != null) data['content'] = content;
    if (description != null) data['description'] = description;
    if (isCompleted != null) data['is_completed'] = isCompleted;
    if (projectId != null) data['project_id'] = projectId;
    if (duration != null) data['duration'] = duration;
    if (durationUnit != null) data['duration_unit'] = durationUnit;
    if (dueDate != null) data['due_date'] = dueDate!;
    if (createdAt != null) data['created_at'] = createdAt;
    data['labels'] = labels;
    return data;
  }

  String get status {
    if (labels!.contains('todo')) return 'To Do';
    if (labels!.contains('inprogress')) return 'In Progress';
    if (labels!.contains('completed')) return 'Done';
    return 'To Do'; // Default status
  }

  void setStatus(String newStatus) {
    labels!.removeWhere(
        (label) => ['todo', 'inprogress', 'completed'].contains(label));
    switch (newStatus) {
      case 'To Do':
        labels!.add('todo');
        break;
      case 'In Progress':
        labels!.add('inprogress');
        break;
      case 'Done':
        labels!.add('completed');
        break;
    }
  }
}

class Due {
  String? date;
  String? string;
  String? lang;
  bool? isRecurring;
  String? datetime;

  Due({this.date, this.string, this.lang, this.isRecurring, this.datetime});

  Due.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    string = json['string'];
    lang = json['lang'];
    isRecurring = json['is_recurring'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (date != null) data['date'] = date;
    if (string != null) data['string'] = string;
    if (lang != null) data['lang'] = lang;
    if (isRecurring != null) data['is_recurring'] = isRecurring;
    if (datetime != null) data['datetime'] = datetime;
    return data;
  }
}
