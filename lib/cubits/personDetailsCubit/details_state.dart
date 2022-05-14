part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class FetchDetailsLoading extends DetailsState {}

class FetchDetailsLoaded extends DetailsState {}

class FetchDetailsError extends DetailsState {
  final String errorMessage;

  FetchDetailsError(this.errorMessage);
}
