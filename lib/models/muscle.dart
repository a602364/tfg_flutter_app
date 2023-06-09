import 'dart:convert';

class Muscle {
  final String name;

  Muscle({required this.name});

  factory Muscle.fromJson(String str) => Muscle.fromMap(json.decode(str));

  factory Muscle.fromMap(Map<String, dynamic> json) => Muscle(
        name: json.values.first,
      );
}



// final List<Muscle> allMuscles = [
//   Muscle(name: "abductors"),
//   Muscle(name: "abs"),
//   Muscle(name: "adductors"),
//   Muscle(name: "biceps"),
//   Muscle(name: "calves"),
//   Muscle(name: "cardiovascular system"),
//   Muscle(name: "delts"),
//   Muscle(name: "forearms"),
//   Muscle(name: "glutes"),
//   Muscle(name: "hamstrings"),
//   Muscle(name: "lats"),
//   Muscle(name: "levator scapulae"),
//   Muscle(name: "pectorals"),
//   Muscle(name: "quads"),
//   Muscle(name: "serratus anterior"),
//   Muscle(name: "spine"),
//   Muscle(name: "traps"),
//   Muscle(name: "triceps"),
//   Muscle(name: "upper back"),
// ];
