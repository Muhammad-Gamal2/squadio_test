import 'helpers.dart';

class ImageWrap {
  String wrapImage({
    required String? imageUrl,
  }) {
    if (imageUrl == null) {
      return '';
    }
    return imageBaseUrl + imageUrl;
  }
}
