import 'package:fg_assessment/helper/database_helper.dart';
import 'package:flutter/material.dart';

import '../models/chair.dart';

enum ChairMode { add, edit }

class ChairProvider extends ChangeNotifier {
  late List<Chair> chairs = [];

  Future getChairs() async {
    final chairList = await DatabaseHelper.getDataFromDatabase();

    chairs = chairList.map((item) => Chair.fromJson(item)).toList();
    notifyListeners();
  }

  Future addOrUpdateNote(
      int id,
      String imagePath,
      String title,
      String description,
      String date,
      String status,
      ChairMode chairMode) async {
    final chair = Chair(
      id: id,
      imagePath: imagePath,
      title: title,
      description: description,
      dateTime: date,
      status: status,
    );
    if (ChairMode.add == chairMode) {
      chairs.insert(0, chair);
    } else {
      chairs[chairs.indexWhere((chair) => chair.id == id)] = chair;
    }
    notifyListeners();

    DatabaseHelper.insert({
      'id': chair.id,
      "imagePath": chair.imagePath,
      'title': chair.title,
      'description': chair.description,
      'dateTime': chair.dateTime,
      'status': chair.status,
    });
  }
}
