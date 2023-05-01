// To parse this JSON data, do
//
//     final weatherApi = weatherApiFromJson(jsonString);

import 'dart:convert';

import 'package:weather/models/weather/currten_weather_api.dart';
import 'package:weather/models/weather/location_weather.dart';

WeatherApi weatherApiFromJson(String str) =>
    WeatherApi.fromJson(json.decode(str));

String weatherApiToJson(WeatherApi data) => json.encode(data.toJson());

class WeatherApi {
  WeatherApi({
    required this.location,
    required this.current,
  });

  Location location;
  Current current;

  factory WeatherApi.fromJson(Map<String, dynamic> json) => WeatherApi(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
      };
}

class Condition {
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  String text;
  String icon;
  int code;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}
