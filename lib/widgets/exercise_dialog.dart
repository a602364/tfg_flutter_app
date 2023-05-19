import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_flutter_app/models/user.dart';
import '../models/models.dart';
import '../repository/exercise_respository.dart';

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
  final exerciseRepository = Get.put(ExerciseRepository());
  bool isExerciseFavorite = false;

  @override
  void initState() {
    super.initState();
    checkExerciseFavorite();
  }

  Future<void> checkExerciseFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    final userModel = UserModel(id: user!.uid, email: user.email!);
    final exercise = Exercise(
      bodyPart: widget.exercise.bodyPart,
      equipment: widget.exercise.equipment,
      gifUrl: widget.exercise.gifUrl,
      id: widget.exercise.id,
      name: widget.exercise.name,
      target: widget.exercise.target,
    );

    final isFavorite =
        await exerciseRepository.isExerciseInFavorites(userModel, exercise);
    setState(() {
      isExerciseFavorite = isFavorite;
    });
  }

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
                widget.exercise.name.capitalizeFirstLetter(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 15),
              Image(image: NetworkImage(widget.exercise.gifUrl)),
              const SizedBox(height: 25),
              ListBody(children: [
                Text(
                  "\u2022 Muscle Working on:\n${widget.exercise.target.capitalizeFirstLetter()}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "\u2022 You are using:\n${widget.exercise.bodyPart.capitalizeFirstLetter()}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "\u2022 Equipment you need:\n${widget.exercise.equipment.capitalizeFirstLetter()}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ]),
              const SizedBox(height: 25),
              Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    final userModel =
                        UserModel(id: user!.uid, email: user.email!);
                    final exercise = Exercise(
                      bodyPart: widget.exercise.bodyPart,
                      equipment: widget.exercise.equipment,
                      gifUrl: widget.exercise.gifUrl,
                      id: widget.exercise.id,
                      name: widget.exercise.name,
                      target: widget.exercise.target,
                    );

                    if (!isExerciseFavorite) {
                      await exerciseRepository.addFavExercise(
                          userModel, exercise);
                      setState(() {
                        isExerciseFavorite = true;
                      });
                    } else {
                      await exerciseRepository.deleteFavExercise(
                          userModel, exercise);
                      setState(() {
                        isExerciseFavorite = false;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isExerciseFavorite
                          ? Colors.green
                          : Colors.yellow[800],
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 250,
                    duration: const Duration(milliseconds: 500),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isExerciseFavorite
                              ? Icons.check
                              : Icons.star_rate_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isExerciseFavorite
                              ? "Already in favorites"
                              : "Add to favorites",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
