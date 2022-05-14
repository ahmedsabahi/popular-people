import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_people/models/people_model.dart';
import 'package:popular_people/services/remote/internet.dart';
import 'package:popular_people/services/remote/people_service.dart';
import 'package:popular_people/ui/personDetails/person_details_screen.dart';

class PersonCard extends StatefulWidget {
  const PersonCard(
    this.person, {
    Key? key,
  }) : super(key: key);

  final Result person;

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool _connected = true;
  @override
  void initState() {
    () async {
      _connected = await Internet.checkConnectivity();
      if (!_connected) setState(() => _connected = false);
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    // print(widget.person.profilePath);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PersonDetailsScreen(widget.person),
        ));
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Hero(
                tag: widget.person.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: PeopleService.imageBaseUrl +
                        widget.person.profilePath.toString(),
                    width: mediaQuery.width * 0.4,
                    height: mediaQuery.height * .21,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.person.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (widget.person.knownFor != null)
                      Wrap(
                        children: widget.person.knownFor!.map((movie) {
                          return Text(
                            '${movie.title ?? ''}${movie.title == null ? '' : ','} ',
                            style: const TextStyle(fontSize: 14),
                          );
                        }).toList(),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
