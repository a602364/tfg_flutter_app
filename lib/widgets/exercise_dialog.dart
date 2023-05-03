import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class ExerciseDialog extends StatefulWidget {
  const ExerciseDialog({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;

  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.exercise.name.capitalize(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 15),
              Image(image: NetworkImage(widget.exercise.gifUrl)),
              const SizedBox(height: 25),
              ListBody(children: [
                Text(
                  "\u2022 Muscle Working on:\n${widget.exercise.target.capitalize()}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "\u2022 You are using:\n${widget.exercise.bodyPart.capitalize()}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "\u2022 Equipment you need:\n${widget.exercise.equipment.capitalize()}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ]),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
