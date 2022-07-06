part of 'person_details_cubit.dart';

abstract class PersonDetailsState extends Equatable {
  const PersonDetailsState();
}

class PersonDetailsInitial extends PersonDetailsState {
  @override
  List<Object> get props => [];
}

class PersonDetailsLoadSuccess extends PersonDetailsState {
  const PersonDetailsLoadSuccess({
    required this.person,
  });

  final Person person;

  @override
  List<Object> get props => <Object>[person];
}

class PersonDetailsLoadFailure extends PersonDetailsState {
  const PersonDetailsLoadFailure({
    required this.error,
  });

  final CustomException error;

  @override
  List<Object> get props => <Object>[error];
}
