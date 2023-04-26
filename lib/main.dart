import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_flutter_app/providers/ui_provider.dart';
import 'package:tfg_flutter_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UiProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym Reminder',
        initialRoute: "home",
        routes: {
          "routines": (_) => RoutineScreen(),
          "home": (_) => HomeScreen(),
          "settings": (_) => SettingsScreen(),
          "chronometer": (_) => ChronometerScreen()
        },
      ),
    );
  }
}
