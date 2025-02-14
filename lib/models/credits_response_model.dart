// To parse this JSON data, do
//
//     final creditsResponse = creditsResponseFromJson(jsonString);

import 'dart:convert';

CreditsResponse creditsResponseFromJson(String str) => CreditsResponse.fromJson(json.decode(str));


class CreditsResponse {
    int id;
    List<Cast> cast;
    List<Cast> crew;

    CreditsResponse({
        required this.id,
        required this.cast,
        required this.crew
    });

    factory CreditsResponse.fromJson(String str) => 
      CreditsResponse.fromMap(json.decode(str));

    factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
    );
}

class Cast {
    bool adult;
    int gender;
    int id;
    Department knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    // int? castId;
    String? character;
    // String creditId;
    // int? order;
    // Department? department;
    // String? job;

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        // this.castId,
        this.character,
        // required this.creditId,
        // this.order,
        // this.department,
        // this.job,
    });

    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        name: json["name"],
        originalName: json["original_name"],
         popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"] ?? '',
        // castId: json["cast_id"] ?? 0,
        character: json['character'] ?? 'Sin personaje',
        // creditId: json["credit_id"],
        // order: json["order"] ?? 0,
        // department: departmentValues.map[json["department"]]! ?? Department.ACTING,
        // job: json["job"]?? '',
    );

    factory Cast.fromPreferences(Map<String,dynamic> json) => Cast(
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: departmentValues.map[json['knownForDepartment']]!,
      name: json['name'],
      originalName: json['originalName'],
      popularity: json['popularity'].toDouble(),
      profilePath: json['profilePath'],
      character: json['character']
    );

    get fullPosterImg {
      if (profilePath == '') return '';
      if (profilePath != null) {
        return 'https://image.tmdb.org/t/p/w500$profilePath';
      }
      return 'https://i.stack.imgur.com/GNhx0.png';
    }

    Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'gender': gender,
      'id': id,
      'knownForDepartment': 'Acting',
      'name': name,
      'originalName': originalName,
      'popularity': popularity,
      'profilePath': profilePath,
      'character': character,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

}

enum Department {
    ACTING,
    ART,
    CAMERA,
    COSTUME_MAKE_UP,
    CREW,
    DIRECTING,
    EDITING,
    LIGHTING,
    PRODUCTION,
    SOUND,
    VISUAL_EFFECTS,
    WRITING
}

final departmentValues = EnumValues({
    "Acting": Department.ACTING,
    "Art": Department.ART,
    "Camera": Department.CAMERA,
    "Costume & Make-Up": Department.COSTUME_MAKE_UP,
    "Crew": Department.CREW,
    "Directing": Department.DIRECTING,
    "Editing": Department.EDITING,
    "Lighting": Department.LIGHTING,
    "Production": Department.PRODUCTION,
    "Sound": Department.SOUND,
    "Visual Effects": Department.VISUAL_EFFECTS,
    "Writing": Department.WRITING
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
