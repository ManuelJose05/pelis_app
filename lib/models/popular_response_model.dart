// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromJson(jsonString);

import 'dart:convert';

import 'package:pelis_app/models/movie_model.dart';

PopularResponse popularResponseFromJson(String str) => PopularResponse.fromJson(json.decode(str));

class PopularResponse {
    int page;
    List<Movie> movies;
    int totalPages;
    int totalResults;

    PopularResponse({
        required this.page,
        required this.movies,
        required this.totalPages,
        required this.totalResults,
    });

    factory PopularResponse.fromJson(String str) => PopularResponse.fromMap(json.decode(str));

    factory PopularResponse.fromMap(Map<String,dynamic> json) => PopularResponse(
      page: json['page'], 
      movies: List<Movie>.from(json['results'].map((x) => Movie.fromJson(x))), 
      totalPages: json['total_pages'], 
      totalResults: json['total_results']
    );
}