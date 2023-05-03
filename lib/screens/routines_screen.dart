import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_flutter_app/models/exercise.dart';
import 'package:tfg_flutter_app/providers/exercises_provider.dart';
import 'package:tfg_flutter_app/widgets/card_table.dart';

import '../search/search_delegate.dart';
import '../widgets/routine_slider.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exercisesProvider = Provider.of<ExerciseProvider>(context);
    TextEditingController textController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContainerComponent(
              texto: "Muscle Groups",
              widget: RoutineSlider(
                muscles: exercisesProvider.onDisplayMuscles,
                title: "Muscles",
              ),
            ),
            ContainerComponent(
              texto: "Exercises",
              widget:
                  CardTable(exercises: exercisesProvider.onDisplayExercises),
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
