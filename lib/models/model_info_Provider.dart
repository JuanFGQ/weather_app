// To parse this JSON data, do
//
//     final mapBoxResponse = mapBoxResponseFromMap(jsonString);

import 'dart:convert';

MapBoxResponse mapBoxResponseFromMap(String str) =>
    MapBoxResponse.fromMap(json.decode(str));

String mapBoxResponseToMap(MapBoxResponse data) => json.encode(data.toMap());

class MapBoxResponse {
  MapBoxResponse({
    // required this.type,
    // required this.query,
    required this.features,
    // required this.attribution,
  });

  // String type;
  // List<String> query;
  List<Feature> features;
  // String attribution;

  factory MapBoxResponse.fromMap(Map<String, dynamic> json) => MapBoxResponse(
        // type: json["type"],
        // query: List<String>.from(json["query"].map((x) => x)),
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        // attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        // "type": type,
        // "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        // "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.placeName,
    required this.center,
    required this.geometry,
  });

  String placeName;
  List<double> center;
  Geometry geometry;

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
      );

  Map<String, dynamic> toMap() => {
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
      };
}

enum Language { EN }

final languageValues = EnumValues({"en": Language.EN});

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
