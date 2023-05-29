import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/models/exercise.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'exercise_dialog.dart';

class CardTable extends StatelessWidget {
  const CardTable({Key? key, required this.exercises}) : super(key: key);

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
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ExerciseDialog(exercise: exercises[i]),
                );
              },
              child: _SingleCard(
                exercise: exercises[i],
              ),
            ),
            if (i + 1 < exercises.length)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        ExerciseDialog(exercise: exercises[i + 1]),
                  );
                },
                child: _SingleCard(
                  exercise: exercises[i + 1],
                ),
              ),
            if (i + 1 >= exercises.length) const _EmptyCard(),
          ])
      ],
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SingleCardBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 35,
            child: Icon(
              Icons.star,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Add more favorites!",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleCard extends StatelessWidget {
  const _SingleCard({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return _SingleCardBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                image: NetworkImage(exercise.gifUrl),
                placeholder: const AssetImage("assets/loading-spinner.gif"),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              exercise.name.capitalizeFirstLetter(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(fontSize: 16),
            ),
          ),
        ],
      ),
    );
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
            border: Border.all(width: 3, color: AppTheme.primary),
          ),
          child: child,
        ),
      ),
    );
  }
}
