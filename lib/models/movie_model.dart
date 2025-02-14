import 'package:pelis_app/models/now_playing_response_model.dart';

class Movie {
    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath;
    String? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;
    String? heroId;

    Movie({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
         this.posterPath,
         this.releaseDate,
        required this.title,
         required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    factory Movie.fromJsonPeliId(Map<String, dynamic> json) {
    Movie temp = Movie(
      adult: true,
      genreIds: [],
      video: false,
        backdropPath: json["backdrop_path"] ?? '',
        id: json["id"] ?? 0,
        originalLanguage: json["original_language"] ?? 'unknown',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? 'Sin descripción',
        popularity: (json["popularity"] ?? 0).toDouble(),
        posterPath:  json['poster_path'] ?? '',
        releaseDate: json["release_date"] ?? '',
        title: json["title"] ?? 'Sin título',
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
        voteCount: json["vote_count"] ?? 0,
    );
    temp.heroId = 'slider-${temp.id}';
    return temp;
    }

    get fullPosterImg {
      if (posterPath != null) return 'https://image.tmdb.org/t/p/w500$posterPath';
      return 'https://i.sstatic.net/GNhx0.png';
    }
}