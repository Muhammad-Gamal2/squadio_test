import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_repository/people_repository.dart';
import 'package:squadio_test/people/blocs/popular_people/popular_people_cubit.dart';

import 'popular_people_from.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularPeopleCubit>(
      create: (context) => PopularPeopleCubit(
          peopleRepository: RepositoryProvider.of<PeopleRepository>(context)),
      child: const PopularPeopleFrom(),
    );
  }
}
