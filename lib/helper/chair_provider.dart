import 'package:fg_assessment/helper/database_helper.dart';
import 'package:flutter/material.dart';

import '../models/chair.dart';

enum ChairMode { add, update }

class ChairProvider extends ChangeNotifier {
  late List<Chair> chairs = [];

  Future getChairs() async {
    final chairList = await DatabaseHelper.getDataFromDatabase();
    chairs = chairList.map((item) => Chair.fromJson(item)).toList();
    notifyListeners();
    return chairs;
  }

  Future addOrUpdateNote(int id, String imagePath, String title,
      String description, String status, ChairMode chairMode) async {
    final chair = Chair(
      id: id,
      imagePath: imagePath,
      title: title,
      description: description,
      status: status,
    );
    if (ChairMode.add == chairMode) {
      chairs.insert(0, chair);
    } else {
      DatabaseHelper.update(chair);
    }
    notifyListeners();

    DatabaseHelper.insert(chair);
  }

  Future deleteChair(int id) async {
    chairs.removeWhere((element) => element.id == id);
    notifyListeners();
    return DatabaseHelper.delete(id);
  }

  Chair getChair(int id) {
    return chairs.firstWhere(
      (chair) => chair.id == id,
    );
  }
}
