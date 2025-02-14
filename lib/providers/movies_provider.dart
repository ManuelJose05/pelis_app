import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelis_app/models/credits_response_model.dart';
import 'package:pelis_app/models/movie_model.dart';
import 'package:pelis_app/models/now_playing_response_model.dart';
import 'package:pelis_app/models/popular_response_model.dart';
import 'package:pelis_app/models/search_response_model.dart';
import 'package:url_launcher/url_launcher.dart';
class MoviesProvider with ChangeNotifier{
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = '9e4fe6bb699228526c524f05e601ea1f';
  final String _language = 'es-ES';

  List<Movie> enCines = [];
  List<Movie> popular = [];
  List<Cast> actoresFavoritos = [];
  List<Movie> pelisFavoritas = [];
  final int _popularPage = 0;
  String rutaFrom = '';

  MoviesProvider() {
    getEnCinesMovies();
    getPopularMovies();
  }

  bool isMovieFavourite(int id) {
    bool existe = false;
    pelisFavoritas.forEach((x) => {
      if (x.id == id) existe = true
    });
    return existe;
  }

  bool isActorFavourite(int idActor) {
    bool existe = false;
    actoresFavoritos.forEach((x) {
      if (x.id == idActor) existe = true;;
    });
    return existe;
  }

  addActorFavoritos(Cast actor) {
    if (!isActorFavourite(actor.id)) actoresFavoritos.add(actor);
    notifyListeners();
  }

  deleteActorFavorito(int id) {
    actoresFavoritos.removeWhere((x) => x.id == id);
    notifyListeners();
  }

  addPelisFavoritas(Movie movie) {
    if (!pelisFavoritas.contains(movie)) pelisFavoritas.add(movie);
    notifyListeners();
  }

  Map<int,List<Cast>> movieCast = {};

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromMap(jsonDecode(jsonData));
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<String> _getJsonData(String endpoint, [int page = 1,String term = '']) async {
    var url = Uri.https(_urlBase,endpoint,{'api_key':_apiKey,'language':_language,'page':'$page',if (term != '') 'query': term});
    final response = await http.get(url);
    return response.body;
  }

  getEnCinesMovies() async {
    // ignore: unnecessary_this
    var url = Uri.https(this._urlBase, '3/movie/now_playing', {
      'api_key':_apiKey, 'language':_language,'page':'1'
    });
    var response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    enCines = nowPlayingResponse.movies;
    notifyListeners();
  }

  getPopularMovies() async {
    // ignore: unnecessary_this
    var url = Uri.https(this._urlBase, '3/movie/popular', {
      'api_key':_apiKey, 'language':_language,'page':'1'
    });
    var response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popular = popularResponse.movies;
    notifyListeners();
  }

  Future<List<Movie>> searchMovie(String term) async {
    final jsonData = await _getJsonData('3/search/movie',1,term);
    final searchMovieResponse = searchResponseFromJson(jsonData);

    List<Movie> movies = searchMovieResponse.results;

    movies.sort((a,b) {
      DateTime dateA = DateTime.parse(a.releaseDate!);
      DateTime dateB = DateTime.parse(b.releaseDate!);
      return dateB.compareTo(dateA);
    });

    return movies ;
  }

  void deleteMovieFavorita(int idPeli) {
    pelisFavoritas.removeWhere((x) => x.id == idPeli);
    notifyListeners();
  }

  Future<String> getTrailerUrl(int movieId) async {
  final String url = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$_apiKey&language=es-ES';

  final response = await http.get(Uri.parse(url));

    final Map<String, dynamic> data = json.decode(response.body);
    final videos = data['results'] as List;

    if (videos.isNotEmpty) {
      final trailer = videos.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );

      if (trailer != null) {
        return 'https://www.youtube.com/watch?v=${trailer['key']}';
      }
    }
    return '';
}

Future openYouTube(String urlVideo) async {
    final Uri url = Uri.parse(urlVideo);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<Movie> getMovieById(int id) async {
    final jsonData = await _getJsonData('/3/movie/$id',1);
    final movie = Movie.fromJsonPeliId(jsonDecode(jsonData));
    return movie;
  }


}