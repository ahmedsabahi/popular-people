import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesInitial());

  static ImagesCubit get(BuildContext context) => BlocProvider.of(context);
}
