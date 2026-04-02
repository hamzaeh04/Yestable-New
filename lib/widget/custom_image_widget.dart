import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/core/services/base_services.dart';
BaseService baseService = BaseService();

class CustomProfileWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double radius;
  final BoxFit fit;

  const CustomProfileWidget({
    super.key,
    required this.imageUrl,
    this.width = 50,
    this.height = 50,
    this.radius = 50,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,

        /// Loading shimmer
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
            ),
          );
        },

        /// Error fallback
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: const Icon(
              Icons.person,
              size: 30,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

Widget customImageWidget({required String imagePath, double? height, double? width}){
  return Image.network(
    "${baseService.baseURL}${imagePath}",
    fit: BoxFit.cover,
    height: height ?? 35.h,
    width: width != null ? width: null,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;

      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.white),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        color: Colors.grey[300],
        child: Icon(Icons.error),
      );
    },
  );
}