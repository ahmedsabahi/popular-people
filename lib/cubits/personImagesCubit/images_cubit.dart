import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:popular_people/models/images_model.dart';
import 'package:popular_people/repositories/people_repository.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesInitial());

  static ImagesCubit get(BuildContext context) => BlocProvider.of(context);

  final _peopleRepository = PeopleRepository();

  ImagesModel? _images;

  ImagesModel? get images => _images;

  Future<void> fetchImages(int personId) async {
    emit(FetchImagesLoading());
    try {
      _images = await _peopleRepository.fetchImages(personId);
      emit(FetchImagesLoaded());
    } catch (e) {
      emit(FetchImagesError(e.toString()));
    }
  }

  Future<void> downloadImage(String imgPath) async {
    emit(DownloadImageLoading());
    if (await Permission.storage.request().isGranted) {
      try {
        final image = await _peopleRepository.downloadImage(imgPath);
        await ImageGallerySaver.saveImage(Uint8List.fromList(image));
        emit(DownloadImageLoaded());
      } catch (e) {
        emit(DownloadImageError(e.toString()));
      }
    } else {
      emit(DownloadImageError('Permission denied'));
    }
  }
}
