import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:network_service/network_service.dart';
import 'package:people_repository/people_repository.dart';

part 'popular_people_state.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleState> {
  PopularPeopleCubit({required PeopleRepository peopleRepository})
      : _peopleRepository = peopleRepository,
        super(PopularPeopleInitial());

  final PeopleRepository _peopleRepository;
  late PeoplePage _peoplePage;

  Future<void> loadPopularPeople({
    required String apiKey,
    required int page,
    String language = "en-US",
  }) async {
    if (page == 1) {
      emit(PopularPeopleInitial());
      _peoplePage = PeoplePage.empty;
    }
    try {
      if (_peoplePage == PeoplePage.empty) {
        _peoplePage = await _peopleRepository.getPopularPeople(
          apiKey: apiKey,
          page: page,
          language: language,
        );
        _peopleRepository.putProductTypeCache(_peoplePage);
        emit(PopularPeopleLoadSuccess(
            peoplePage: _peoplePage,
            isLastPage: page == _peoplePage.totalPages ? true : false,
            newPersons: _peoplePage.results));
      } else if (page <= _peoplePage.totalPages) {
        final PeoplePage newPeoplePage =
            await _peopleRepository.getPopularPeople(
          apiKey: apiKey,
          page: page,
          language: language,
        );
        _peoplePage = _peoplePage.copyWith(
            results: _peoplePage.results + newPeoplePage.results,
            page: newPeoplePage.page);
        emit(PopularPeopleLoadSuccess(
            peoplePage: _peoplePage,
            isLastPage: page == _peoplePage.totalPages ? true : false,
            newPersons: newPeoplePage.results));
      }
    } on CustomException catch (error) {
      emit(PopularPeopleLoadFailure(
          error: error,
          peoplePage: state.peoplePage,
          isLastPage: state.isLastPage));
      if (error.errorType == Errors.internetException) {
        try {
         final cachePopularPeople = _peopleRepository.getPopularPeopleCache();
          emit(PopularPeopleLoadSuccess(
              peoplePage: cachePopularPeople,
              isLastPage: true,
              newPersons: cachePopularPeople.results));
        } catch (_) {}
      }
    } catch (error) {
      emit(PopularPeopleLoadFailure(
          error: CustomException(
            message: "tryAgain".tr(),
            errorType: Errors.builtInException,
          ),
          peoplePage: state.peoplePage,
          isLastPage: state.isLastPage));
    }
  }
}
