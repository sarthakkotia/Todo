import 'package:flutter/material.dart';
import '../Models/task_model.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SampleTaskWidget extends StatefulWidget {
  Task taskdetails;
  SampleTaskWidget(this.taskdetails, {super.key});

  @override
  State<SampleTaskWidget> createState() => _SampleTaskWidgetState();
}

class _SampleTaskWidgetState extends State<SampleTaskWidget> {
  @override
  Widget build(BuildContext context) {
    Task taskdetails = widget.taskdetails;
    return Opacity(
      opacity: widget.taskdetails.iscompleted == true ? 0.5 : 1,
      child: Card(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          shadowColor: Theme.of(context).colorScheme.secondary,
          elevation: 5,
          child: ListTile(
            title: Text(taskdetails.title,
                style: taskdetails.iscompleted == true
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : const TextStyle()),
            subtitle: (taskdetails.description != null
                ? Text(taskdetails.description ?? "",
                    style: taskdetails.iscompleted == true
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough)
                        : const TextStyle())
                : null),
            leading: Checkbox(
              onChanged: (value) {
                setState(() {
                  taskdetails.togglecompletion();
                  setState(() {});
                });
              },
              value: taskdetails.iscompleted,
              checkColor: Colors.white,
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
            trailing: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.grey,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  DateFormat('d/M/yyyy').format(taskdetails.duedate),
                  style: taskdetails.iscompleted == true
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : const TextStyle(),
                ),
              ),
            ),
          )),
    );
  }
}
