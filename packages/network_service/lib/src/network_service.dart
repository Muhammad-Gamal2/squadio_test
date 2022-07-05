import 'package:dio/dio.dart';

import 'custom_exception.dart';

class NetworkService {
  NetworkService({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  final Dio _dio;

  static const _baseUrl = 'https://api.themoviedb.org/3';

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      return await _dio.get(url,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.response:
          handleErrorsMsgCodes(error.response!);
        default:
          throw const CustomException(errorType: Errors.internetException);
      }
    }
  }
}
