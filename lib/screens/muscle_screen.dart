import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tfg_flutter_app/providers/exercises_provider.dart';
import 'package:tfg_flutter_app/repository/exercise_repository.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:tfg_flutter_app/widgets/exercise_dialog.dart';
import '../models/models.dart';
import '../models/user.dart';

class MuscleListScreen extends StatefulWidget {
  const MuscleListScreen({Key? key}) : super(key: key);

  @override
  _MuscleListScreenState createState() => _MuscleListScreenState();
}

class _MuscleListScreenState extends State<MuscleListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final Muscle muscle = ModalRoute.of(context)!.settings.arguments as Muscle;
    final exerciseProvider =
        Provider.of<ExerciseProvider>(context, listen: false);
    final exerciseRepository = Get.put(ExerciseRepository());

    final user = FirebaseAuth.instance.currentUser;
    final userModel = UserModel(id: user!.uid, email: user.email!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text("${muscle.name.capitalizeFirstLetter()} exercises"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: AppTheme.primary,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: exerciseProvider.getExercisesByTargetMuscle(muscle.name),
          builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: SizedBox(
                  height: 180,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              );
            }

            final List<Exercise> exercises = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final Exercise exercise = exercises[index];
                return ListTile(
                  title: Text(exercise.name.capitalizeFirstLetter()),
                  trailing: FutureBuilder(
                    future: exerciseRepository.isExerciseInFavorites(
                        userModel, exercise),
                    builder: (context, favoriteSnapshot) {
                      if (!favoriteSnapshot.hasData) {
                        return const SizedBox();
                      }

                      final bool isFavorite = favoriteSnapshot.data!;
                      final IconData star =
                          isFavorite ? Icons.star : Icons.star_border_outlined;
                      final Color starColor =
                          isFavorite ? Colors.yellow[800]! : Colors.grey;

                      return Icon(
                        star,
                        color: starColor,
                      );
                    },
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ExerciseDialog(exercise: exercise),
                    );
                  },
                );
              },
              itemCount: exercises.length,
            );
          },
        ),
      ),
    );
  }
}
