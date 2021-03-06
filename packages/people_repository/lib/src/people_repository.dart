import 'package:hive/hive.dart';
import 'package:network_service/network_service.dart';
import 'package:people_repository/people_repository.dart';

class PeopleRepository {
  PeopleRepository({NetworkService? networkService})
      : _networkService = networkService ?? NetworkService();

  final NetworkService _networkService;

  /// Fetch Popular people.
  ///
  /// [language] parameter is the user language.
  /// [page] parameter is the page number.
  /// [apiKey] parameter is api key.
  Future<PeoplePage> getPopularPeople({
    required String apiKey,
    required int page,
    required String language,
  }) async {
    const popularPeopleRequest = '/person/popular';

    final response =
        await _networkService.get(popularPeopleRequest, queryParameters: {
      "language": language,
      "api_key": apiKey,
      "page": page,
    });
    return PeoplePage.fromJson(response.data);
  }

  /// Fetch person details.
  ///
  /// [language] parameter is the user language.
  /// [apiKey] parameter is api key.
  /// [personId] parameter is person id.
  Future<Person> getPersonDetails({
    String? language = "en-US",
    required int personId,
    required String apiKey,
  }) async {
    final detailsRequest = '/person/$personId';

    final response =
        await _networkService.get(detailsRequest, queryParameters: {
      "language": language,
      "api_key": apiKey,
    });
    return Person.fromJson(response.data);
  }

  /// Fetch person images.
  ///
  /// [apiKey] parameter is api key.
  /// [personId] parameter is person id.
  Future<List<String>> getPersonImages({
    required int personId,
    required String apiKey,
  }) async {
    final imagesRequest = '/person/$personId/images';

    final response = await _networkService.get(imagesRequest, queryParameters: {
      "api_key": apiKey,
    });
    return List<String>.from((response.data['profiles'] as List<dynamic>)
        .map((image) => image['file_path']));
  }

  /// Fetch popular people from cache.
  PeoplePage getPopularPeopleCache() {
    final box = Hive.box('zidoBox');
    return box.get("popularPeople", defaultValue: PeoplePage.empty);
  }

  /// save popular people to the cache.
  Future<void> putProductTypeCache(PeoplePage peoplePage) async {
    final box = Hive.box('zidoBox');
    await box.put("popularPeople", peoplePage);
  }
}
