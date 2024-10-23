class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool iscompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iscompleted,
  });

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      iscompleted: json['is_completed'],
    );
  }
}
