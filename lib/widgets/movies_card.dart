import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popular_people/models/people_model.dart';
import 'package:popular_people/services/remote/people_service.dart';

class MoviesCard extends StatelessWidget {
  const MoviesCard(
    this.person, {
    Key? key,
  }) : super(key: key);

  final Result person;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: person.knownFor!.length,
        itemBuilder: (context, index) {
          final movie = person.knownFor![index];

          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(20),
            ),
            width: mediaQuery.width * 0.9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: PeopleService.imageBaseUrl +
                        movie.posterPath.toString(),
                    fit: BoxFit.cover,
                    errorWidget: (ctx, url, e) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.title ?? movie.originalTitle.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: movie.voteAverage / 2,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (ctx, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          Text(' ${movie.voteAverage}/10')
                        ],
                      ),
                      const SizedBox(height: 5),
                      if (movie.releaseDate != null)
                        Text('Release date: ${movie.releaseDate}'),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          movie.overview,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
