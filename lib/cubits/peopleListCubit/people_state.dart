part of 'people_cubit.dart';

@immutable
abstract class PeopleState {}

class PeopleInitial extends PeopleState {}

class FetchPeopleLoading extends PeopleState {}

class FetchPeopleLoaded extends PeopleState {}

class FetchPeopleError extends PeopleState {
  final String message;

  FetchPeopleError(this.message);
}
