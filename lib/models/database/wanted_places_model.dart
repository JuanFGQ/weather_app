// To parse this JSON data, do
//
//     final searchePlaces = searchePlacesFromJson(jsonString);

import 'dart:convert';

WantedPlacesModel searchePlacesFromJson(String str) =>
    WantedPlacesModel.fromJson(json.decode(str));

String searchePlacesToJson(WantedPlacesModel data) =>
    json.encode(data.toJson());

class WantedPlacesModel {
  int? id;
  String placeName;
  String placeCoords;

  WantedPlacesModel({
    this.id,
    required this.placeName,
    required this.placeCoords,
  });

  factory WantedPlacesModel.fromJson(Map<String, dynamic> json) =>
      WantedPlacesModel(
        id: json["id"],
        placeName: json["placeName"],
        placeCoords: json["placeCoords"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "PlaceName": placeName,
        "PlaceCoords": placeCoords,
      };
}
