import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/task_model.dart';
import 'package:intl/intl.dart';
import '../Provider/task_provider.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({super.key});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  final _descfocusnode = FocusNode();

  final _form = GlobalKey<FormState>();
  var date = DateTime.now();

  Task edittask = Task(
    title: "",
    description: "",
    duedate: DateTime.now(),
    id: DateTime.now().toString(),
  );

  @override
  void dispose() {
    _descfocusnode.dispose();
    super.dispose();
  }

  void saveform() {
    final isvalid = _form.currentState!.validate();
    if (isvalid == false) {
      return;
    }

    _form.currentState?.save();
    Navigator.of(context).pop();
    Provider.of<TaskProvider>(context, listen: false).addtask(edittask);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Form(
              key: _form,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: true,
                      decoration: const InputDecoration(
                          label: Text(
                            "Title",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hintText: "Title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_descfocusnode);
                      },
                      onSaved: (newValue) {
                        edittask = Task(
                            title: newValue.toString(),
                            description: edittask.description,
                            duedate: edittask.duedate,
                            id: edittask.id);
                      },
                      validator: (value) {
                        String nvalue = value as String;
                        if (nvalue.isEmpty) {
                          return "Title shall not be Empty!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      focusNode: _descfocusnode,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
                      decoration: const InputDecoration(
                          label: Text(
                            "Description",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hintText: "Description"),
                      onSaved: (newValue) {
                        edittask = Task(
                            title: edittask.title,
                            description: newValue,
                            duedate: edittask.duedate,
                            id: edittask.id);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: date,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(date.year + 10,
                                            date.month, date.day))
                                    .then((value) {
                                  if (value == null) return;
                                  setState(() {
                                    date = value;
                                    edittask.duedate = date;
                                  });
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Row(children: [
                                IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: date,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(date.year + 10,
                                                date.month, date.day))
                                        .then((value) {
                                      if (value == null) return;
                                      setState(() {
                                        date = value;
                                        edittask.duedate = date;
                                      });
                                    });
                                  },
                                  icon:
                                      const Icon(Icons.calendar_month_outlined),
                                  splashRadius: 23,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    DateFormat('d/M/yyyy').format(date),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                )
                              ]),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              saveform();
                            },
                            icon: const Icon(
                              Icons.send,
                              size: 35,
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
