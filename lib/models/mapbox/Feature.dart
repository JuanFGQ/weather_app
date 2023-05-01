import '../mapBox_response.dart';

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
