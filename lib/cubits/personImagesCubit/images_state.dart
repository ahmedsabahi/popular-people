part of 'images_cubit.dart';

@immutable
abstract class ImagesState {}

class ImagesInitial extends ImagesState {}

class FetchImagesLoading extends ImagesState {}

class FetchImagesLoaded extends ImagesState {}

class FetchImagesError extends ImagesState {
  final String message;

  FetchImagesError(this.message);
}

class DownloadImageLoading extends ImagesState {}

class DownloadImageLoaded extends ImagesState {}

class DownloadImageError extends ImagesState {
  final String message;

  DownloadImageError(this.message);
}
