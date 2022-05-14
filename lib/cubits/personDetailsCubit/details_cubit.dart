import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:popular_people/models/details_model.dart';
import 'package:popular_people/repositories/people_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  static DetailsCubit get(BuildContext context) => BlocProvider.of(context);

  final _peopleRepository = PeopleRepository();

  DetailsModel? _details;

  DetailsModel? get details => _details;

  Future<void> fetchDetails(int personId) async {
    emit(FetchDetailsLoading());
    try {
      _details = await _peopleRepository.fetchDetails(personId);
      emit(FetchDetailsLoaded());
    } catch (e) {
      emit(FetchDetailsError(e.toString()));
    }
  }
}
