import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// Used to differentiate between different types of exception
///
/// [internetException] happens when there's no internet connection.
///
/// [builtInException] when there's a different error happening or unknown error so that we show a built-in text.
///
/// [serverException] when an error occur with 404 and 401 status code.
///
/// The first three exceptions need to be translated.
enum Errors {
  internetException,
  builtInException,
  serverException,
}

/// Handles different exceptions, whether they're internet, authentication, or normal exceptions.
///
/// [_message] is not necessary when [errorType] is [Errors.internetException]
class CustomException extends Equatable implements Exception {
  const CustomException({
    required this.errorType,
    this.message = '',
  });

  final Errors errorType;
  final String message;

  @override
  String toString() {
    switch (errorType) {
      case Errors.internetException:
        return 'Please check your internet connection and try again.';
      case Errors.builtInException:
      case Errors.serverException:
        return message;
      default:
        return message;
    }
  }

  @override
  List<Object?> get props => [errorType, message];
}

Never handleErrorsMsgCodes(Response? response) {
  if (response != null) {
    if (response.statusCode == 401 || response.statusCode == 404) {
      throw CustomException(
          errorType: Errors.serverException,
          message: response.data['message'].toString());
    } else if (response.statusCode != 200) {
      throw const CustomException(
        errorType: Errors.builtInException,
        message: 'Something went wrong, please try again.',
      );
    }
  }
  throw const CustomException(
      errorType: Errors.builtInException, message: 'Something went wrong, please try again.');
}
