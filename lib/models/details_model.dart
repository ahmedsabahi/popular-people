// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  DetailsModel({
    required this.birthday,
    required this.knownForDepartment,
    required this.deathday,
    required this.id,
    required this.name,
    required this.alsoKnownAs,
    required this.gender,
    required this.biography,
    required this.popularity,
    required this.placeOfBirth,
    required this.profilePath,
    required this.adult,
    required this.imdbId,
    required this.homepage,
  });

  final DateTime birthday;
  final String knownForDepartment;
  final dynamic deathday;
  final int id;
  final String name;
  final List<String> alsoKnownAs;
  final int gender;
  final String biography;
  final double popularity;
  final String placeOfBirth;
  final String profilePath;
  final bool adult;
  final String imdbId;
  final dynamic homepage;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        birthday: DateTime.parse(json["birthday"]),
        knownForDepartment: json["known_for_department"],
        deathday: json["deathday"],
        id: json["id"],
        name: json["name"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        gender: json["gender"],
        biography: json["biography"],
        popularity: json["popularity"].toDouble(),
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"],
      );

  Map<String, dynamic> toJson() => {
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "known_for_department": knownForDepartment,
        "deathday": deathday,
        "id": id,
        "name": name,
        "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
        "gender": gender,
        "biography": biography,
        "popularity": popularity,
        "place_of_birth": placeOfBirth,
        "profile_path": profilePath,
        "adult": adult,
        "imdb_id": imdbId,
        "homepage": homepage,
      };
}
