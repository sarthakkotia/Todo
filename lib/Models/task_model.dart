import 'package:flutter/material.dart';

class Task with ChangeNotifier {
  final String title;
  //this id can later be changed through firebase
  final String id;
  String? description;
  DateTime duedate;
  bool iscompleted = false;

  Task({
    required this.title,
    required this.description,
    required this.duedate,
    required this.id,
  });

  void togglecompletion() {
    iscompleted = !iscompleted;
    notifyListeners();
  }

  void taskdatechange(DateTime value) {
    duedate = value;
    notifyListeners();
  }
}
