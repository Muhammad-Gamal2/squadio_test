import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_repository/people_repository.dart';
import 'package:squadio_test/people/people.dart';

import '../../helpers/helpers.dart';
import 'person_details_form.dart';

class PersonDetailsPage extends StatelessWidget {
  const PersonDetailsPage({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonDetailsCubit>(
          create: (context) => PersonDetailsCubit(
            peopleRepository: RepositoryProvider.of<PeopleRepository>(context),
          )..loadPersonDetails(
              apiKey: apiKey,
              personId: person.id,
            ),
        ),
        BlocProvider<PersonImagesCubit>(
          create: (context) => PersonImagesCubit(
              peopleRepository:
                  RepositoryProvider.of<PeopleRepository>(context))
            ..loadPersonImages(
              apiKey: apiKey,
              personId: person.id,
            ),
        ),
      ],
      child: const PersonDetailsForm(),
    );
  }
}
