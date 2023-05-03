import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_flutter_app/providers/exercises_provider.dart';
import 'package:tfg_flutter_app/providers/ui_provider.dart';
import 'package:flutter/services.dart';
import 'package:tfg_flutter_app/screens/screens.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExerciseProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Reminder',
      initialRoute: "home",
      theme: AppTheme.light,
      routes: {
        "routines": (_) => RoutineScreen(),
        "home": (_) => HomeScreen(),
        "settings": (_) => SettingsScreen(),
        "chronometer": (_) => ChronometerScreen(),
        "muscleList": (_) => MuscleListScreen()
      },
    );
  }
}
