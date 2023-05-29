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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {}
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text("Favorite Exercises"),
      ),
      body: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          children: [
            Stack(
              children: [
                Visibility(
                  visible: isLoading,
                  child: Center(
                    child: Container(
                      height: size.height * 0.8,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isLoading && favoriteExercises.isEmpty,
                  child: Container(
                    height: size.height * 0.8,
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "There is not favorite exercises",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey[350],
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.star,
                            size: 50,
                            color: Colors.grey[350],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isLoading && favoriteExercises.isNotEmpty,
                  child: CardTable(exercises: favoriteExercises),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
