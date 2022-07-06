part of 'person_images_cubit.dart';

abstract class PersonImagesState extends Equatable {
  const PersonImagesState();
}

class PersonImagesInitial extends PersonImagesState {
  @override
  List<Object> get props => [];
}

class PersonImagesLoadSuccess extends PersonImagesState {
  const PersonImagesLoadSuccess({
    required this.images,
  });

  final List<String> images;

  @override
  List<Object> get props => <Object>[images];
}

class PersonImagesLoadFailure extends PersonImagesState {
  const PersonImagesLoadFailure({
    required this.error,
  });

  final CustomException error;

  @override
  List<Object> get props => <Object>[error];
}
