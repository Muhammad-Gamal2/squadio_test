import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:network_service/network_service.dart';
import 'package:people_repository/people_repository.dart';

part 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit({required PeopleRepository peopleRepository})
      : _peopleRepository = peopleRepository,
        super(PersonDetailsInitial());

  final PeopleRepository _peopleRepository;

  Future<void> loadPersonDetails({
    required String apiKey,
    String? language,
    required int personId,
  }) async {
    try {
      final person = await _peopleRepository.getPersonDetails(
        apiKey: apiKey,
        language: language,
        personId: personId,
      );
      emit(PersonDetailsLoadSuccess(person: person));
    } on CustomException catch (error) {
      emit(PersonDetailsLoadFailure(
        error: error,
      ));
    } catch (error) {
      emit(PersonDetailsLoadFailure(
        error: CustomException(
          message: "tryAgain".tr(),
          errorType: Errors.builtInException,
        ),
      ));
    }
  }
}
