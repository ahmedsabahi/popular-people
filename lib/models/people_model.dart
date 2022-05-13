// To parse this JSON data, do
//
//     final popularModel = popularModelFromJson(jsonString);

import 'dart:convert';

PeopleModel peopleModelFromJson(String str) =>
    PeopleModel.fromJson(json.decode(str));

String popularModelToJson(PeopleModel data) => json.encode(data.toJson());

class PeopleModel {
  PeopleModel({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  final int page;
  final List<Result> results;
  final int totalResults;
  final int totalPages;

  factory PeopleModel.fromJson(Map<String, dynamic> json) => PeopleModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class Result {
  Result({
    required this.profilePath,
    required this.adult,
    required this.id,
    required this.knownFor,
    required this.name,
    required this.popularity,
  });

  final String? profilePath;
  final bool adult;
  final int id;
  final List<KnownFor> knownFor;
  final String name;
  final double popularity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        profilePath: json["profile_path"],
        adult: json["adult"],
        id: json["id"],
        knownFor: List<KnownFor>.from(
            json["known_for"].map((x) => KnownFor.fromJson(x))),
        name: json["name"],
        popularity: json["popularity"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "profile_path": profilePath,
        "adult": adult,
        "id": id,
        "known_for": List<dynamic>.from(knownFor.map((x) => x.toJson())),
        "name": name,
        "popularity": popularity,
      };
}

class KnownFor {
  KnownFor({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.originalTitle,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
    required this.firstAirDate,
    required this.originCountry,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final bool adult;
  final String overview;
  final String? releaseDate;
  final String originalTitle;
  final List<int> genreIds;
  final int id;
  final MediaType? mediaType;
  final OriginalLanguage? originalLanguage;
  final String title;
  final String? backdropPath;
  final double? popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;
  final DateTime? firstAirDate;
  final List<String>? originCountry;
  final String name;
  final String originalName;

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        posterPath: json["poster_path"],
        adult: json["adult"] ?? false,
        overview: json["overview"],
        releaseDate: json["release_date"],
        originalTitle: json["original_title"] ?? 'null',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        mediaType: mediaTypeValues.map![json["media_type"]],
        originalLanguage:
            originalLanguageValues.map![json["original_language"]],
        title: json["title"] ?? 'null',
        backdropPath: json["backdrop_path"] ?? 'null',
        popularity:
            json["popularity"] == null ? 0.0 : json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"] ?? false,
        voteAverage: json["vote_average"].toDouble(),
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        name: json["name"] ?? 'null',
        originalName: json["original_name"] ?? 'null',
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "adult": adult,
        "overview": overview,
        "release_date": releaseDate,
        "original_title": originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "media_type": mediaTypeValues.reverse[mediaType],
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "title": title,
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "vote_average": voteAverage,
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "name": name,
        "original_name": originalName,
      };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV,
});

enum OriginalLanguage { EN, CN }

final originalLanguageValues = EnumValues({
  "cn": OriginalLanguage.CN,
  "en": OriginalLanguage.EN,
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return map!.map((k, v) => MapEntry(v, k));
  }
}
