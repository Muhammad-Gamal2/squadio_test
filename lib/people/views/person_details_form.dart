import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../people.dart';

class PersonDetailsForm extends StatelessWidget {
  const PersonDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PersonDetailsCubit, PersonDetailsState>(
          listener: (context, state) {
            if (state is PersonDetailsLoadFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.error.toString()),
                  ),
                );
            }
          },
        ),
        BlocListener<PersonImagesCubit, PersonImagesState>(
          listener: (context, state) {
            if (state is PersonImagesLoadFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.error.toString()),
                  ),
                );
            }
          },
        ),
      ],
      child: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state is PersonDetailsLoadSuccess
                  ? state.person.name
                  : 'loading'.tr()),
            ),
            body: state is PersonDetailsLoadSuccess
                ? PersonDetailsCard(person: state.person)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
