import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import '../Screens/today_screen.dart';
import '../Screens/theme_screen.dart';
import '../Screens/upcoming_screen.dart';

class ThemeLogic extends StatelessWidget {
  const ThemeLogic({super.key});

  AppTheme buildtheme(
      String id,
      String description,
      MaterialColor primaryswatch,
      MaterialColor accentcolor,
      Brightness brightness) {
    return AppTheme(
      id: id, // Id(or name) of the theme(Has to be unique)
      description: description, // Description of theme
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: primaryswatch,
            accentColor: accentcolor,
            brightness: brightness),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: false,
      onInitCallback: (controller, previouslySavedThemeFuture) async {
        String? savedTheme = await previouslySavedThemeFuture;
        if (savedTheme != null) {
          controller.setTheme(savedTheme);
        } else {}
      },
      themes: [
        buildtheme("amberlight", "Amber", Colors.amber, Colors.amber,
            Brightness.light),
        buildtheme(
            "amberdark", "Amber", Colors.amber, Colors.amber, Brightness.dark),
        buildtheme("light", "Blue", Colors.blue, Colors.blue, Brightness.light),
        buildtheme("dark", "Blue", Colors.blue, Colors.blue, Brightness.dark),
        buildtheme("purplelight", "Purple", Colors.purple, Colors.purple,
            Brightness.light),
        buildtheme("purpledark", "Purple", Colors.purple, Colors.purple,
            Brightness.dark),
        buildtheme("greenlight", "Green", Colors.green, Colors.green,
            Brightness.light),
        buildtheme(
            "greendark", "Green", Colors.green, Colors.green, Brightness.dark),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (context) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.themeOf(context).data,
            home: const TodayScreen(),
            routes: {
              ThemeScreen.routename: (context) => const ThemeScreen(),
              TodayScreen.routename: (context) => const TodayScreen(),
              UpcomingScreen.routename: (context) => const UpcomingScreen()
            },
          ),
        ),
      ),
    );
  }
}
