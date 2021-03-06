import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:popular_people/models/details_model.dart';
import 'package:popular_people/models/images_model.dart';
import 'package:popular_people/models/people_model.dart';

class PeopleService {
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  final _baseUrl = 'api.themoviedb.org';
  final _apiKey = '72220a92bc527a38d756c861d142785f';
  final _language = 'en-US';

  Future<List<Result>> fetchPeople(int pageNum) async {
    final uri = Uri.https(_baseUrl, '/3/person/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': pageNum.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // if (kDebugMode) print("response body: ${response.body}");
      return peopleModelFromJson(response.body).results;
    } else {
      throw Exception('Failed to fetch people ${response.statusCode}');
    }
  }

  Future<DetailsModel> fetchDetails(int personId) async {
    final uri = Uri.https(_baseUrl, '/3/person/$personId', {
      'api_key': _apiKey,
      'language': _language,
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // if (kDebugMode) print("response body: ${response.body}");
      return detailsModelFromJson(response.body);
    } else {
      throw Exception('Failed to fetch details ${response.statusCode}');
    }
  }

  Future<ImagesModel> fetchImages(int personId) async {
    final uri = Uri.https(_baseUrl, '/3/person/$personId/images', {
      'api_key': _apiKey,
      'language': _language,
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // if (kDebugMode) print("response body: ${response.body}");
      return imagesModelFromJson(response.body);
    } else {
      throw Exception('Failed to fetch images ${response.statusCode}');
    }
  }

  Future<Uint8List> downloadImage(String imgPath) async {
    final uri = Uri.parse(imageBaseUrl + imgPath);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch image ${response.statusCode}');
    }
  }
}
