import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/models/exercise.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'exercise_dialog.dart';

class CardTable extends StatelessWidget {
  const CardTable({super.key, required this.exercises});

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (exercises.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Table(
      children: [
        for (var i = 0; i < exercises.length; i += 2)
          TableRow(children: [
            _SingleCard(
              color: Colors.black,
              icon: Icons.fitness_center,
              text: exercises[i].name,
              img: exercises[i].gifUrl,
              exercise: exercises[i],
            ),
            if (i + 1 < exercises.length)
              _SingleCard(
                color: Colors.black,
                icon: Icons.fitness_center,
                text: exercises[i + 1].name,
                img: exercises[i + 1].gifUrl,
                exercise: exercises[i + 1],
              ),
          ])
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  const _SingleCard({
    Key? key,
    required this.color,
    required this.text,
    required this.icon,
    required this.img,
    required this.exercise,
  }) : super(key: key);

  final Color color;
  final String text;
  final IconData icon;
  final String img;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return _SingleCardBackground(
        child: GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, "details", arguments: exercise);
        showDialog(
            context: context,
            builder: (context) => ExerciseDialog(exercise: exercise));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundColor: color,
              radius: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(image: NetworkImage(img)),
              )),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text.capitalizeFirstLetter(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                color: color,
                fontSize: 16,
              )),
            ),
          ),
        ],
      ),
    ));
  }
}

class _SingleCardBackground extends StatelessWidget {
  const _SingleCardBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 175,
          decoration: BoxDecoration(
              color: AppTheme.secondary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3, color: AppTheme.primary)),
          child: child,
        ),
      ),
    );
  }
}
