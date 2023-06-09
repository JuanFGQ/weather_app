// To parse this JSON data, do
//
//     final savedCitiesModel = savedCitiesModelFromJson(jsonString);

import 'dart:convert';

SavedCitiesModel savedCitiesModelFromJson(String str) =>
    SavedCitiesModel.fromJson(json.decode(str));

String savedCitiesModelToJson(SavedCitiesModel data) =>
    json.encode(data.toJson());

class SavedCitiesModel {
  int? id;
  String title;
  String temperature;
  String updated;
  String wind;

  SavedCitiesModel({
    this.id,
    required this.title,
    required this.temperature,
    required this.updated,
    required this.wind,
  });

  factory SavedCitiesModel.fromJson(Map<String, dynamic> json) =>
      SavedCitiesModel(
        id: json["id"],
        title: json["title"],
        temperature: json["temperature"],
        updated: json["updated"],
        wind: json["wind"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "temperature": temperature,
        "updated": updated,
        "wind": wind,
      };
}
