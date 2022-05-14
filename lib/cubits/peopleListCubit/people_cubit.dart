import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:popular_people/models/people_model.dart';
import 'package:popular_people/repositories/people_repository.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial()) {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll == currentScroll) fetchPeople();
    });
    fetchPeople();
  }

  static PeopleCubit get(BuildContext context) => BlocProvider.of(context);

  int _pageNum = 1;
  final List<Result> _results = [];

  final _scrollController = ScrollController();
  final _peopleRepository = PeopleRepository();

  List<Result> get results => _results;
  ScrollController get scrollController => _scrollController;

  Future<void> fetchPeople() async {
    emit(FetchPeopleLoading());
    try {
      final newResults = await _peopleRepository.fetchPeople(_pageNum);
      _results.addAll(newResults);
      // or _results = [..._results, ...newResults];
      _pageNum++;
      emit(FetchPeopleLoaded());
    } catch (e) {
      emit(FetchPeopleError(e.toString()));
    }
  }
}
