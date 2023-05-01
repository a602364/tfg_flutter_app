import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/models/exercise.dart';
import 'package:tfg_flutter_app/providers/exercises_provider.dart';
import 'package:tfg_flutter_app/widgets/card_table.dart';

import '../widgets/routine_slider.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // ContainerComponent(
            //   texto: "Routines",
            //   widget: RoutineSlider(),
            // ),
            ContainerComponent(
              texto: "Exercises",
              widget: CardTable(),
            )
          ],
        ),
      ),
    );
  }
}

class ContainerComponent extends StatelessWidget {
  const ContainerComponent({
    Key? key,
    required this.texto,
    required this.widget,
  }) : super(key: key);

  final String texto;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [TitleText(text: texto), widget],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
