part of 'popular_people_cubit.dart';

abstract class PopularPeopleState extends Equatable {
  const PopularPeopleState({
    this.peoplePage = PeoplePage.empty,
    this.isLastPage = false,
  });

  final PeoplePage peoplePage;
  final bool isLastPage;
}

class PopularPeopleInitial extends PopularPeopleState {
  @override
  List<Object> get props => [];
}

class PopularPeopleLoadSuccess extends PopularPeopleState {
  const PopularPeopleLoadSuccess({
    required this.newPersons,
    required PeoplePage peoplePage,
    bool isLastPage = false,
  }) : super(isLastPage: isLastPage, peoplePage: peoplePage);

  final List<Person> newPersons;

  @override
  List<Object> get props => <Object>[peoplePage, isLastPage, newPersons];
}

class PopularPeopleLoadFailure extends PopularPeopleState {
  const PopularPeopleLoadFailure({
    required this.error,
    required PeoplePage peoplePage,
    bool isLastPage = false,
  }) : super(isLastPage: isLastPage, peoplePage: peoplePage);

  final CustomException error;

  @override
  List<Object> get props => <Object>[error];
}
