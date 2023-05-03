import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tfg_flutter_app/models/models.dart';
import 'package:tfg_flutter_app/models/muscle.dart';
import '../helper/debouncer.dart';

class ExerciseProvider extends ChangeNotifier {
  final String _baseUrl = "exercisedb.p.rapidapi.com";
  final String _apiKey = "16b2c8d491mshff2c83a52a1a374p1b43edjsnadb37cd5a71e";

  final Map<String, String> _requestHeaders = {
    'X-RapidAPI-Key': '16b2c8d491mshff2c83a52a1a374p1b43edjsnadb37cd5a71e',
    'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
  };

  List<Exercise> onDisplayExercises = [];
  List<Exercise> onDisplayExercisesByMuscle = [];
  List<Exercise> onDisplayExercisesBySearch = [];
  List<Muscle> onDisplayMuscles = [];

  final debouncer = Debouncer(duration: const Duration(milliseconds: 350));

  final StreamController<List<Exercise>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Exercise>> get suggestionStream =>
      _suggestionStreamController.stream;

  ExerciseProvider() {
    print("ExerciseProvider inicializado");

    final List<String> muscleNames = [
      "abductors",
      "abs",
      "adductors",
      "biceps",
      "calves",
      "cardiovascular system",
      "delts",
      "forearms",
      "glutes",
      "hamstrings",
      "lats",
      "levator scapulae",
      "pectorals",
      "quads",
      "serratus anterior",
      "spine",
      "traps",
      "triceps",
      "upper back"
    ];

    getExercises();
    getMuscles(muscleNames);
  }

  Future<String> _getJsonData(
      String endpoint, Map<String, String> headers) async {
    final url = Uri.https(_baseUrl, endpoint, {"api_key": _apiKey});

    final response = await http.get(url, headers: headers);
    return response.body;
  }

  getExercises() async {
    final jsonData = await _getJsonData("exercises", _requestHeaders);
    final decodedData = jsonDecode(jsonData);
    final exercises = List<Exercise>.from(
      (decodedData as List<dynamic>).map(
        (exerciseJson) => Exercise.fromMap(exerciseJson),
      ),
    );

    exercises.shuffle();
    onDisplayExercises = exercises.take(16).toList();
    notifyListeners();
  }

  Future<List<Exercise>> getExercisesByMuscle(String target) async {
    final jsonData =
        await _getJsonData("exercises/target/$target", _requestHeaders);
    final decodedData = jsonDecode(jsonData);
    final exercises = List<Exercise>.from(
      (decodedData as List<dynamic>).map(
        (exerciseJson) => Exercise.fromMap(exerciseJson),
      ),
    );

    onDisplayExercisesByMuscle = exercises.toList();
    return exercises.toList();
  }

  getMuscles(List<String> muscleNames) async {
    final muscles = muscleNames.map((name) => Muscle(name: name)).toList();
    onDisplayMuscles = muscles;
    notifyListeners();
  }

  //TODO Search bar en ejercicios favoritos
  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      final results = await searchExercises(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }

  Future<List<Exercise>> searchExercises(String name) async {
    final jsonData =
        await _getJsonData("exercises/name/%7B$name%7D", _requestHeaders);
    final decodedData = jsonDecode(jsonData);
    final exercises = List<Exercise>.from(
      (decodedData as List<dynamic>).map(
        (exerciseJson) => Exercise.fromMap(exerciseJson),
      ),
    );

    exercises.shuffle();
    onDisplayExercisesBySearch = exercises.toList();
    print(exercises.toString() + "hola");
    return exercises.toList();
  }
}
