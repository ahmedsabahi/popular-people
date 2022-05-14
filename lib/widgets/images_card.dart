import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_people/cubits/personImagesCubit/images_cubit.dart';
import 'package:popular_people/models/people_model.dart';
import 'package:popular_people/services/remote/people_service.dart';
import 'package:popular_people/ui/personImage/person_image_screen.dart';

class ImagesCard extends StatelessWidget {
  const ImagesCard(
    this.person, {
    Key? key,
  }) : super(key: key);

  final Result person;

  @override
  Widget build(BuildContext context) {
    final circularProgress = CircularProgressIndicator.adaptive(
      backgroundColor: Theme.of(context).colorScheme.background,
    );
    return BlocConsumer<ImagesCubit, ImagesState>(
      listener: (context, state) {},
      builder: (context, state) {
        final imagesCubit = ImagesCubit.get(context);
        final images = imagesCubit.images;

        if (state is FetchImagesError) Center(child: Text(state.message));

        if (state is FetchImagesLoading) Center(child: circularProgress);
        if (imagesCubit.images == null) {
          return const SizedBox();
        } else {
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5.0),
            itemCount: images!.profiles.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              mainAxisExtent: 150.0,
            ),
            itemBuilder: (BuildContext context, index) {
              final image = images.profiles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PersonImageScreen(
                      person: person,
                      filePath: image.filePath.toString(),
                    ),
                  ));
                },
                child: Hero(
                  tag: image.filePath.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: PeopleService.imageBaseUrl +
                          image.filePath.toString(),
                      fit: BoxFit.cover,
                      errorWidget: (ctx, url, e) => const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
