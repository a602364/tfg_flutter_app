import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tfg_flutter_app/models/exercise.dart';
import 'package:tfg_flutter_app/models/user.dart';

class ExerciseRepository extends GetxController {
  static ExerciseRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<bool> isExerciseInFavorites(UserModel user, Exercise exercise) async {
    final userRef = _db.collection('users').doc(user.id);
    final favoritosRef = userRef.collection('favExercises');

    final exerciseDoc = await favoritosRef.doc(exercise.id).get();
    return exerciseDoc.exists;
  }

  addFavExercise(UserModel user, Exercise exercise) async {
    final isExerciseFavorite = await isExerciseInFavorites(user, exercise);

    if (!isExerciseFavorite) {
      final userRef = _db.collection('users').doc(user.id);
      final favoritosRef = userRef.collection('favExercises');

      await favoritosRef.doc(exercise.id).set(exercise.toJson());
    }
  }

  deleteFavExercise(UserModel user, Exercise exercise) async {
    final isExerciseFavorite = await isExerciseInFavorites(user, exercise);

    if (isExerciseFavorite) {
      final userRef = _db.collection('users').doc(user.id);
      final favoritosRef = userRef.collection('favExercises');

      await favoritosRef.doc(exercise.id).delete();
    }
  }
}
