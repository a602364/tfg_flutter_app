import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_flutter_app/providers/ui_provider.dart';
import 'package:tfg_flutter_app/screens/routines_screen.dart';
import 'package:tfg_flutter_app/screens/screens.dart';
import 'package:tfg_flutter_app/widgets/custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: _HomePageBody(), bottomNavigationBar: CustomNavigationBar());
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return RoutineScreen();
      case 1:
        return ChronometerScreen();
      case 2:
        return SettingsScreen();
      default:
        //!TODO Meter LoginScreen
        return RoutineScreen();
    }
  }
}
