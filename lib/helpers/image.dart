import 'helpers.dart';

class ImageWrap {
  const ImageWrap({this.imageUrl});

  final String? imageUrl;

  String wrapImage() {
    if (imageUrl == null) {
      return '';
    }
    return imageBaseUrl + imageUrl!;
  }
}
