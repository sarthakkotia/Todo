import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/task_model.dart';
import 'package:intl/intl.dart';
import '../Provider/task_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskAction extends StatelessWidget {
  const TaskAction({super.key});
  @override
  Widget build(BuildContext context) {
    final taskdetails = Provider.of<Task>(context);

    return Consumer<Task>(
      builder: (context, _, __) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Theme.of(context).colorScheme.secondary,
          ),
          onDismissed: (direction) {
            Provider.of<TaskProvider>(context, listen: false)
                .deletetask(taskdetails);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Task deleted from the list"),
              behavior: SnackBarBehavior.fixed,
              duration: Duration(seconds: 1),
            ));
          },
          child: Opacity(
            opacity: taskdetails.iscompleted == true ? 0.5 : 1,
            child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                shadowColor: Theme.of(context).colorScheme.secondary,
                elevation: 5,
                child: ListTile(
                  title: Text(taskdetails.title,
                      style: taskdetails.iscompleted == true
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough)
                          : const TextStyle()),
                  subtitle: taskdetails.description!.isEmpty == true
                      ? null
                      : Text(
                          taskdetails.description!,
                          style: taskdetails.iscompleted == true
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough)
                              : const TextStyle(),
                        ),
                  leading: Checkbox(
                    onChanged: (value) {
                      taskdetails.togglecompletion();
                      if (taskdetails.iscompleted == true) {
                        AudioPlayer player = AudioPlayer();
                        player.play(AssetSource("Sounds/switch-sound.mp3"));
                      }
                      Provider.of<TaskProvider>(context, listen: false)
                          .sortlist();
                    },
                    value: taskdetails.iscompleted,
                    checkColor: Colors.white,
                    activeColor: Theme.of(context).colorScheme.secondary,
                  ),
                  trailing: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: taskdetails.duedate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(taskdetails.duedate.year + 10,
                            taskdetails.duedate.month, taskdetails.duedate.day),
                      ).then((value) {
                        if (value == null) return;
                        taskdetails.taskdatechange(value);
                        Provider.of<TaskProvider>(context, listen: false)
                            .taskdatechanged(taskdetails);
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.grey,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        DateFormat('d/M/yyyy').format(taskdetails.duedate),
                        style: taskdetails.iscompleted == true
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : const TextStyle(),
                      ),
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
