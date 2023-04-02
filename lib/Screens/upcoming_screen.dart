import 'package:flutter/material.dart';
import '../Widgets/tasks_list_upcoming.dart';
import '../Widgets/add_modal_sheet.dart';
import '../Screens/theme_screen.dart';
import '../Widgets/drawer_widget.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});
  static const routename = '/upcoming';

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Upcoming"),
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
            child: const TasksListUpcoming()),
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
