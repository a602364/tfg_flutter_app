import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tfg_flutter_app/models/models.dart';
import '../helper/debouncer.dart';
import '../secrets/secret_loader.dart';

class ExerciseProvider extends ChangeNotifier {
  final String _baseUrl = "exercisedb.p.rapidapi.com";
  final Map<String, String> _requestHeaders = {
    'X-RapidAPI-Key': "",
    'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
  };

  _loadApiKey() async {
    final secret =
        await SecretLoader(secretPath: "lib/secrets/secrets.json").load();
    _requestHeaders['X-RapidAPI-Key'] = secret.apiKey;
  }

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
    _loadApiKey();
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
    final url = Uri.https(
        _baseUrl, endpoint, {"api_key": _requestHeaders['X-RapidAPI-Key']});

    final response = await http.get(url, headers: headers);
    return response.body;
  }

  getExercises() async {
    await _loadApiKey();
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
    print("${exercises}hola");
    return exercises.toList();
  }
}
