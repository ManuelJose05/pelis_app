// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromJson(jsonString);

import 'dart:convert';

import 'package:pelis_app/models/movie_model.dart';

NowPlayingResponse nowPlayingResponseFromJson(String str) => NowPlayingResponse.fromJson(json.decode(str));

class NowPlayingResponse {
    Dates dates;
    int page;
    List<Movie> movies;
    int totalPages;
    int totalMovies;

    NowPlayingResponse({
        required this.dates,
        required this.page,
        required this.movies,
        required this.totalPages,
        required this.totalMovies,
    });

    factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));

    factory NowPlayingResponse.fromMap(Map<String,dynamic> json) => NowPlayingResponse(
      dates: Dates.fromJson(json['dates']), 
      page: json['page'], 
      movies: List<Movie>.from(json['results'].map((x) => Movie.fromJson(x))), 
      totalPages: json['total_pages'], 
      totalMovies: json['total_results']
      );
}

class Dates {
    DateTime maximum;
    DateTime minimum;

    Dates({
        required this.maximum,
        required this.minimum,
    });

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}

enum OriginalLanguage {
    EN,
    ES,
    FR,
    LV
}

final originalLanguageValues = EnumValues({
    "en": OriginalLanguage.EN,
    "es": OriginalLanguage.ES,
    "fr": OriginalLanguage.FR,
    "lv": OriginalLanguage.LV
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
