//

import 'dart:convert';

import 'Feature.dart';

MapBoxResponse mapBoxResponseFromMap(String str) =>
    MapBoxResponse.fromMap(json.decode(str));

String mapBoxResponseToMap(MapBoxResponse data) => json.encode(data.toMap());

class MapBoxResponse {
  MapBoxResponse({
    required this.features,
  });

  List<Feature> features;

  factory MapBoxResponse.fromMap(Map<String, dynamic> json) => MapBoxResponse(
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
      };
}

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
