import 'package:flutter/material.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen(
    this.personId, {
    Key? key,
  }) : super(key: key);

  final int personId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Details'),
      ),
      body: Center(
        child: Text('Person Details Screen'),
      ),
    );
  }
}
