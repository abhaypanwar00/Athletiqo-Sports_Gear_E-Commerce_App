import 'package:athletiqo/utils/constants/sizes.dart';
import 'package:athletiqo/utils/loaders/shimmer_loaders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding,
    this.isNetworkImage = false,
    this.fit = BoxFit.cover,
    required this.image,
  });

  final double width, height; 
  final double? padding;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ?? AppSizes.sm),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: isNetworkImage
            ? CachedNetworkImage(
                fit: fit,
                color: overlayColor,
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    ShimmerEffect(
                  width: width,
                  height: height,
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.red),
              )
            : Image(
                fit: fit,
                image: AssetImage(image),
                color: overlayColor,
              ),
      ),
    );
  }
}
