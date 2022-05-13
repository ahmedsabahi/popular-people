// To parse this JSON data, do
//
//     final imagesModel = imagesModelFromJson(jsonString);

import 'dart:convert';

ImagesModel imagesModelFromJson(String str) =>
    ImagesModel.fromJson(json.decode(str));

String imagesModelToJson(ImagesModel data) => json.encode(data.toJson());

class ImagesModel {
  ImagesModel({
    required this.id,
    required this.profiles,
  });

  final int id;
  final List<Profile> profiles;

  factory ImagesModel.fromJson(Map<String, dynamic> json) => ImagesModel(
        id: json["id"],
        profiles: List<Profile>.from(
            json["profiles"].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profiles": List<dynamic>.from(profiles.map((x) => x.toJson())),
      };
}

class Profile {
  Profile({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.iso6391,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  final double aspectRatio;
  final String filePath;
  final int height;
  final dynamic iso6391;
  final double voteAverage;
  final int voteCount;
  final int width;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "file_path": filePath,
        "height": height,
        "iso_639_1": iso6391,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
