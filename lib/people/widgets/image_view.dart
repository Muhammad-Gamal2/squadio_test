import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:squadio_test/helpers/helpers.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Hero(
                tag: image,
                child: Image.network(
                  ImageWrap(imageUrl: image).wrapImage(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              left: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: const Color(0x1A000000),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Container(
                    color: const Color(0x1A000000),
                    child: IconButton(
                      icon: const Icon(
                        Icons.save_alt,
                        color: Colors.white,
                      ),
                      onPressed: () => GallerySaver.saveImage(
                          ImageWrap(imageUrl: image).wrapImage()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
