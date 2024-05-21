import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/api_urls.dart';

class LoadingImage extends StatelessWidget {
  final BoxFit? fit;

  const LoadingImage({
    super.key,
    required this.imageUrl,
    this.fit,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ApiUrls.imageBaseUrl + imageUrl,
      fit: fit ?? BoxFit.fill,
      fadeOutDuration: const Duration(milliseconds: 500),
      placeholder: (context, url) => const Center(
        child: SizedBox(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
      // loadingBuilder: (BuildContext context, Widget child,
      //     ImageChunkEvent? loadingProgress) {
      //   if (loadingProgress == null) {
      //     return child;
      //   }
      //   return Center(
      //     child: SizedBox(
      //       child: CircularProgressIndicator(
      //         value: loadingProgress.expectedTotalBytes != null
      //             ? loadingProgress.cumulativeBytesLoaded /
      //                 loadingProgress.expectedTotalBytes!
      //             : null,
      //       ),
      //     ),
      //   );
      // },
      // errorBuilder:
      //     (BuildContext context, Object exception, StackTrace? stackTrace) {
      //   return const Center(
      //     child: Icon(
      //       Icons.error_outline,
      //       color: Colors.red,
      //     ),
      //   );
      // },
    );
  }
}

class S3LoadingImage extends StatelessWidget {
  final BoxFit? fit;

  const S3LoadingImage({
    super.key,
    required this.imageUrl,
    this.fit,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.fill,
      fadeOutDuration: const Duration(milliseconds: 0),
      fadeInDuration: const Duration(milliseconds: 0),
      fadeOutCurve: Curves.linear,
      fadeInCurve: Curves.linear,
      // placeholder: (context, url) => const Center(
      //   child: SizedBox(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
      progressIndicatorBuilder: (context, child, loadingProgress) {
        return Center(
          child: CircularProgressIndicator.adaptive(
            value: loadingProgress.progress,
          ),
        );
      },
      // errorBuilder:
      //     (BuildContext context, Object exception, StackTrace? stackTrace) {
      //   return const Center(
      //     child: Icon(
      //       Icons.error_outline,
      //       color: Colors.red,
      //     ),
      //   );
      // },
    );
  }
}
