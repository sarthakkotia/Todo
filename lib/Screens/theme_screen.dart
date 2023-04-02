import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import '../Models/task_model.dart';
import '../Widgets/sample_task_widget.dart';

class ThemeScreen extends StatefulWidget {
  static const routename = '/theme';

  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

bool isdark = false;
List<bool> selections = List.generate(4, (index) => false);
Task sampletask = Task(
    title: "Sample title",
    description: "Sample Description",
    duedate: DateTime.now(),
    id: DateTime.now().toString());

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeController controller = ThemeProvider.controllerOf(context);
    if (controller.theme.id == "dark" ||
        controller.theme.id == "greendark" ||
        controller.theme.id == "purpledark" ||
        controller.theme.id == "amberdark") {
      isdark = true;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isdark = !isdark;
                selections.fillRange(0, 4, false);
                selections[1] = true;
                if (isdark == false) {
                  controller.setTheme('light');
                } else {
                  controller.setTheme('dark');
                }
              });
            },
            icon: Icon(isdark == true ? Icons.wb_sunny : Icons.nights_stay),
          )
        ],
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Theme"),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Change Theme",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  isSelected: selections,
                  renderBorder: false,
                  children: const [
                    Icon(color: Colors.amber, Icons.square),
                    Icon(color: Colors.blue, Icons.square),
                    Icon(color: Colors.purple, Icons.square),
                    Icon(color: Colors.green, Icons.square)
                  ],
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < selections.length; i++) {
                        selections[i] = i == index;
                      }
                      if (selections[0] == true && isdark == false) {
                        controller.setTheme('amberlight');
                      } else if (selections[0] == true && isdark == true) {
                        controller.setTheme('amberdark');
                      } else if (selections[1] == true && isdark == false) {
                        controller.setTheme('light');
                      } else if (selections[1] == true && isdark == true) {
                        controller.setTheme('dark');
                      } else if (selections[2] == true && isdark == false) {
                        controller.setTheme('purplelight');
                      } else if (selections[2] == true && isdark == true) {
                        controller.setTheme('purpledark');
                      } else if (selections[3] == true && isdark == false) {
                        controller.setTheme('greenlight');
                      } else if (selections[3] == true && isdark == true) {
                        controller.setTheme('greendark');
                      }
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 3,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SampleTaskWidget(sampletask),
            )
          ],
        ),
      ),
    );
  }
}
