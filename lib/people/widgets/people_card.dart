import 'package:flutter/material.dart';
import 'package:people_repository/people_repository.dart';
import 'package:squadio_test/helpers/helpers.dart';

class PeopleCard extends StatelessWidget {
  PeopleCard({Key? key, required this.person}) : super(key: key);

  final Person person;
  final imageWrap = ImageWrap();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: person.profilePath != null
            ? NetworkImage(imageWrap.wrapImage(imageUrl: person.profilePath))
            : null,
        backgroundColor: Colors.grey,
        radius: 20,
      ),
      title: Text(person.name),
    );
  }
}
