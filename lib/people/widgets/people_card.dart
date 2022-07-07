import 'package:flutter/material.dart';
import 'package:people_repository/people_repository.dart';
import 'package:squadio_test/helpers/helpers.dart';

import '../people.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({Key? key, required this.person}) : super(key: key);

  final Person person;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: person.profilePath != null
            ? NetworkImage(
                ImageWrap(imageUrl: person.profilePath).wrapImage(),
              )
            : null,
        backgroundColor: Colors.grey,
        radius: 20,
      ),
      title: Text(person.name),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonDetailsPage(person: person)),
      ),
    );
  }
}
