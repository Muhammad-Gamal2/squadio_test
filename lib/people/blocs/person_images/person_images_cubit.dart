import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:network_service/network_service.dart';
import 'package:people_repository/people_repository.dart';

part 'person_images_state.dart';

class PersonImagesCubit extends Cubit<PersonImagesState> {
  PersonImagesCubit({required PeopleRepository peopleRepository})
      : _peopleRepository = peopleRepository,
        super(PersonImagesInitial());

  final PeopleRepository _peopleRepository;

  Future<void> loadPersonDetails({
    required String apiKey,
    String? language,
    required int personId,
  }) async {
    try {
      final images = await _peopleRepository.getPersonImages(
        apiKey: apiKey,
        personId: personId,
      );
      emit(PersonImagesLoadSuccess(images: images));
    } on CustomException catch (error) {
      emit(PersonImagesLoadFailure(
        error: error,
      ));
    } catch (error) {
      emit(PersonImagesLoadFailure(
        error: CustomException(
          message: "tryAgain".tr(),
          errorType: Errors.builtInException,
        ),
      ));
    }
  }
}
