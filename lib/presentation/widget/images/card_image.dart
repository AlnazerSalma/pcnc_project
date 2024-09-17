// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CardImage extends StatelessWidget {
//   final String imageUrl;
//   final double width;
//   final double height;
//   final String errorImage;
//   final bool isCircular;

//   const CardImage({
//     super.key,
//     required this.imageUrl,
//     required this.width,
//     required this.height,
//     required this.errorImage,
//     this.isCircular = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Widget image = Image.network(
//       imageUrl,
//       width: width.w,
//       height: height.h,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) {
//         return Image.asset(
//           errorImage,
//           width: width.w,
//           height: height.h,
//           fit: BoxFit.cover,
//         );
//       },
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) {
//           return child;
//         } else {
//           return Center(
//             child: CircularProgressIndicator(
//               value: loadingProgress.expectedTotalBytes != null
//                   ? loadingProgress.cumulativeBytesLoaded /
//                       (loadingProgress.expectedTotalBytes ?? 1)
//                   : null,
//             ),
//           );
//         }
//       },
//     );
//     return isCircular ? ClipOval(child: image) : image;
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final String errorImage;
  final bool isCircular;

  const CardImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.errorImage,
    this.isCircular = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Image.network(
      imageUrl,
      width: width.w,
      height: height.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          errorImage,
          width: width.w,
          height: height.h,
          fit: BoxFit.cover,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
    );

    return isCircular
        ? ClipOval(child: image)
        : ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: image,
          );
  }
}
