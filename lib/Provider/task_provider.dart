import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/task_model.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskProvider with ChangeNotifier {
  // List<Task> tasks = [
  //   Task(
  //     title: "test",
  //     description: "",
  //     duedate: DateTime.now(),
  //     id: DateTime.now().toString(),
  //   ),
  //   Task(
  //     title: "test2",
  //     description: "",
  //     duedate: DateTime.now(),
  //     id: DateTime.now().toString(),
  //   )
  // ];

  List<Task> taskstoday = [
    Task(
        title: "today1",
        description: "",
        duedate: DateTime.now(),
        id: DateTime.now().toString()),
    Task(
        title: "today2",
        description: "",
        duedate: DateTime.now(),
        id: DateTime.now().toString())
  ];
  List<Task> tasksupcoming = [];

  // List<Task> get taskslist {
  //   return [...tasks];
  // }

  List<Task> get taskslisttoday {
    return [...taskstoday];
  }

  List<Task> get taskslistupcoming {
    return [...tasksupcoming];
  }

  void addtask(Task newtask) {
    final tasknew = Task(
        title: newtask.title,
        description: newtask.description,
        duedate: newtask.duedate,
        id: DateTime.now().toString());
    // tasks.insert(0, tasknew);

    if (newtask.duedate.day == DateTime.now().day &&
        newtask.duedate.month == DateTime.now().month &&
        newtask.duedate.year == DateTime.now().year) {
      taskstoday.insert(0, tasknew);
    } else {
      tasksupcoming.insert(0, newtask);
    }
    notifyListeners();
  }

  void sortlist() {
    // tasks.sort(
    //   (a, b) => a.iscompleted.toString().compareTo(b.iscompleted.toString()),
    // );
    taskstoday.sort(
      (a, b) => a.iscompleted.toString().compareTo(b.iscompleted.toString()),
    );
    tasksupcoming.sort(
      (a, b) => a.iscompleted.toString().compareTo(b.iscompleted.toString()),
    );
    notifyListeners();
  }

  void deletetask(Task task) {
    int index;

    index = taskstoday.indexWhere((element) {
      if (element.id == task.id) {
        return true;
      }
      return false;
    });
    if (index == -1) {
      index = tasksupcoming.indexWhere((element) {
        if (element.id == task.id) {
          return true;
        }
        return false;
      });
      tasksupcoming.removeAt(index);
      if (tasksupcoming.isEmpty) {
        AudioPlayer player = AudioPlayer();
        player.play(AssetSource("Sounds/completetask_0.mp3"));
      }
    } else {
      taskstoday.removeAt(index);
      if (taskstoday.isEmpty) {
        AudioPlayer player = AudioPlayer();
        player.play(AssetSource("Sounds/completetask_0.mp3"));
      }
    }
    // int index = tasks.indexWhere((element) {
    //   if (element.id == id) {
    //     return true;
    //   }
    //   return false;
    // });
    // tasks.removeAt(index);
    sortlist();
    notifyListeners();
  }

  void taskdatechanged(Task tasknew) {
    if (DateFormat('ddMMyyyy').format(tasknew.duedate) !=
        DateFormat('ddMMyyyy').format(DateTime.now())) {
      deletetask(tasknew);
      addtask(tasknew);
    }
    notifyListeners();
  }
}
