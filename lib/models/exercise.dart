// To parse this JSON data, do
//
//     final exercise = exerciseFromJson(jsonString);

import 'dart:convert';

class Exercise {
  String bodyPart;
  String equipment;
  String gifUrl;
  String id;
  String name;
  String target;

  Exercise({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
  });

  factory Exercise.fromJson(String str) => Exercise.fromMap(json.decode(str));

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        bodyPart: json["bodyPart"],
        equipment: json["equipment"],
        gifUrl: json["gifUrl"],
        id: json["id"],
        name: json["name"],
        target: json["target"],
      );
}
