import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:popular_people/models/details_model.dart';
import 'package:popular_people/models/images_model.dart';
import 'package:popular_people/models/people_model.dart';
import 'package:popular_people/services/local/db_helper.dart';
import 'package:popular_people/services/remote/internet.dart';
import 'package:popular_people/services/remote/people_service.dart';

class PeopleRepository {
  final _peopleService = PeopleService();

  Future<List<Result>> fetchPeople(int pageNum) async {
    // get the network status
    final connected = await Internet.checkConnectivity();
    final dbHelper = DbHelper.instance;

    if (connected) {
      // if there is a network, get data from the api and return it
      final results = await _peopleService.fetchPeople(pageNum);
      // save the posts in db
      if (kDebugMode) print("Hello from api");
      for (final result in results) {
        dbHelper.insert(result.toDB());
      }
      return results;
    } else {
      // if there is no network, return saved data in db
      final savedResults = await dbHelper.queryAllRows();
      if (kDebugMode) print("Hello from database");
      return resultModelFromDB(savedResults);
    }
  }

  Future<ImagesModel> fetchImages(int personId) {
    return _peopleService.fetchImages(personId);
  }

  Future<DetailsModel> fetchDetails(int personId) {
    return _peopleService.fetchDetails(personId);
  }

  Future<Uint8List> downloadImage(String imgPath) {
    return _peopleService.downloadImage(imgPath);
  }
}
