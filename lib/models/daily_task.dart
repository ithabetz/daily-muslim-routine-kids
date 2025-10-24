import 'task_type.dart';

class DailyTask {
  final String id;
  final String title;
  final TaskType taskType;
  bool isCompleted;
  final double weight; // Weight for scoring

  DailyTask({
    required this.id,
    required this.title,
    required this.taskType,
    this.isCompleted = false,
    this.weight = 0.5, // Default for Sunnah tasks
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'taskType': taskType.toString(),
      'isCompleted': isCompleted,
      'weight': weight,
    };
  }

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
      id: json['id'],
      title: json['title'],
      taskType: TaskType.values.firstWhere(
        (e) => e.toString() == json['taskType'],
        orElse: () => TaskType.sunnah,
      ),
      isCompleted: json['isCompleted'] ?? false,
      weight: json['weight'] ?? 0.5,
    );
  }
}

