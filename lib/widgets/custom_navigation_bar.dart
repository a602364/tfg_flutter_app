import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';

import '../providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return ConvexAppBar(
      style: TabStyle.react,
      height: 50,
      top: -25,
      curveSize: 100,
      items: const [
        TabItem(icon: Icons.list, title: "Exercises"),
        TabItem(icon: Icons.timer, title: "Chronometer"),
        TabItem(icon: Icons.settings, title: "Settings"),
      ],
      backgroundColor: AppTheme.primary,
      initialActiveIndex: currentIndex,
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
    );
  }
}
