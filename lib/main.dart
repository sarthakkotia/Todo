import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoadv/Provider/task_provider.dart';
import './Widgets/theme_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TaskProvider(), child: const ThemeLogic());
  }
}
