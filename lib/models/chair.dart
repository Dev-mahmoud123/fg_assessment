import 'package:intl/intl.dart';

class Chair {
  final int id;
  final String imagePath;
  final String title;
  final String description;
  final String status;

  Chair(
      {required this.id,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.status});

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(id);
    return DateFormat('EEE h:mm a, dd/MM/yyyy').format(date);
  }

  factory Chair.fromJson(Map<String, dynamic> data) {
    return Chair(
      id: data["id"],
      imagePath: data["imagePath"],
      title: data["title"],
      description: data["description"],
      status: data["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'description': description,
      'status': status
    };
  }
}
