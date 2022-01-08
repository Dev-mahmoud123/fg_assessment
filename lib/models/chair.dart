class Chair {
  final int id;
  final String imagePath;
  final String title;
  final String description;
  final String dateTime;
  final String status;

  Chair(
      {required this.id,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.status});

  factory Chair.fromJson(Map<String, dynamic> data) {
    return Chair(
      id: data["id"],
      imagePath: data["imagePath"],
      title: data["title"],
      description: data["description"],
      dateTime: data["dateTime"],
      status: data["status"],
    );
  }
}
