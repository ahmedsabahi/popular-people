import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_people/models/people_model.dart';
import 'package:popular_people/services/remote/people_service.dart';
import 'package:popular_people/widgets/movies_card.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen(
    this.person, {
    Key? key,
  }) : super(key: key);

  final Result person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 550.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(person.name),
                    const SizedBox(width: 10),
                    if (person.popularity != null)
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                    if (person.popularity != null)
                      Text(
                        person.popularity.toString(),
                        style: const TextStyle(fontSize: 10),
                      )
                  ],
                ),
                background: Hero(
                  tag: person.id,
                  child: CachedNetworkImage(
                    imageUrl: PeopleService.imageBaseUrl +
                        person.profilePath.toString(),
                    fit: BoxFit.cover,
                    errorWidget: (ctx, url, e) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (person.knownFor != null)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Known For:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              if (person.knownFor != null) MoviesCard(person),
            ],
          ),
        ),
      ),
    );
  }
}
