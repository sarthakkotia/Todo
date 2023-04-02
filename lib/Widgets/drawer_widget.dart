import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Provider/task_provider.dart';
import '../Screens/today_screen.dart';
import '../Screens/upcoming_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tasknumber = Provider.of<TaskProvider>(context, listen: false);
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(25))),
      child: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.12,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.rectangle,
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(50))),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Stack(
              children: [
                const Icon(Icons.calendar_today, size: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 6.5),
                  child: Text(
                    DateFormat('dd').format(DateTime.now()),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            title: const Text(
              "Today",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: Text(tasknumber.taskstoday.length.toString()),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TodayScreen.routename);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_month, size: 30),
            title: const Text(
              "Upcoming",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: Text(tasknumber.tasksupcoming.length.toString()),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UpcomingScreen.routename);
            },
          )
        ],
      ),
    );
  }
}
