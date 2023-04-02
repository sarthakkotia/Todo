import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/task_provider.dart';
import '../Widgets/task_action.dart';

class TasksListToday extends StatelessWidget {
  const TasksListToday({super.key});

  @override
  Widget build(BuildContext context) {
    var task = Provider.of<TaskProvider>(context);
    var tasklist = task.taskslisttoday;
    return tasklist.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/Studio_Project_today.gif",
                fit: BoxFit.contain,
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (_, index) {
              return ChangeNotifierProvider.value(
                value: tasklist[index],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TaskAction(),
                ),
              );
            },
            itemCount: tasklist.length,
          );
  }
}
