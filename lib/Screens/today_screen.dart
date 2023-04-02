import 'package:flutter/material.dart';
import '../Widgets/tasks_list_today.dart';
import '../Widgets/add_modal_sheet.dart';
import '../Screens/theme_screen.dart';
import '../Widgets/drawer_widget.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});
  static const routename = '/today';

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Today"),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ThemeScreen.routename);
            },
            icon: const Icon(Icons.palette))
      ],
    );
    return Scaffold(
      appBar: appbar,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: SizedBox(
            height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.9,
            child: const TasksListToday()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return const ModalSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
