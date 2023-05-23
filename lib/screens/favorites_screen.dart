import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_flutter_app/models/exercise.dart';
import 'package:tfg_flutter_app/models/user.dart';
import 'package:tfg_flutter_app/repository/exercise_repository.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:tfg_flutter_app/widgets/card_table.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Exercise> favoriteExercises = [];
  final ScrollController scrollController = ScrollController();

  final exerciseRepository = Get.put(ExerciseRepository());

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        // fetch more data if needed
      }
    });

    loadFavoriteExercises();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    loadFavoriteExercises();
  }

  Future<void> loadFavoriteExercises() async {
    final user = FirebaseAuth.instance.currentUser;
    final userModel = UserModel(id: user!.uid, email: user.email!);

    final exerciseRepository = ExerciseRepository.instance;
    final exercises = await exerciseRepository.getFavExercises(userModel);
    setState(() {
      favoriteExercises = exercises;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text("Favorite Exercises"),
      ),
      body: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: onRefresh,
        child: ListView(
          controller: scrollController,
          children: [
            CardTable(exercises: favoriteExercises),
          ],
        ),
      ),
    );
  }
}
