import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:popular_people/cubits/personImagesCubit/images_cubit.dart';
import 'package:popular_people/models/people_model.dart';
import 'package:popular_people/services/remote/people_service.dart';

class PersonImageScreen extends StatelessWidget {
  const PersonImageScreen({
    Key? key,
    required this.filePath,
    required this.person,
  }) : super(key: key);

  final String filePath;
  final Result person;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImagesCubit, ImagesState>(
      listener: (context, state) {
        if (state is DownloadImageLoaded) {
          Fluttertoast.showToast(
            msg: 'You have successfully added to your gallery.',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.orange,
          );
        }
        if (state is DownloadImageError) {
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.redAccent,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(person.name),
        ),
        body: LayoutBuilder(
          builder: (buildCtx, constraints) {
            return Hero(
              tag: filePath,
              child: CachedNetworkImage(
                height: constraints.maxHeight,
                fit: BoxFit.cover,
                imageUrl: PeopleService.imageBaseUrl + filePath,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 9.0,
          child: const Icon(Icons.file_download),
          onPressed: () => ImagesCubit.get(context).downloadImage(filePath),
        ),
      ),
    );
  }
}
