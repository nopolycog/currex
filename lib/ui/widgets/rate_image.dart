import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class AppRateImage extends StatelessWidget {
  const AppRateImage({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://assets.coincap.io/assets/icons/${path.toLowerCase()}@2x.png',
      imageBuilder:
          (BuildContext context, ImageProvider<Object> imageProvider) => ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image(image: imageProvider, fit: BoxFit.contain, height: 30, width: 30),
          ),
      placeholder: (_, _) => const SizedBox(),
      errorWidget: (_, _, _) => const SizedBox(),
    );
  }
}
