// import 'package:flutter/material.dart';
// class BannerImage extends StatelessWidget {
//   const BannerImage({
//     super.key,  this.borderRadius=15, this.width=320, this.height, required this.imgUrl,  this.applyImageRadius=false, this.border, this.backgroundColor=Colors.orange, this.fit=BoxFit.contain, this.padding,  this.isNetworkImage=false, this.onPressed,
//   });
//   final double borderRadius;
//   final double?width,height;
//   final String imgUrl;
//   final bool applyImageRadius;
//   final BoxBorder?border;
//   final Color backgroundColor;
//   final BoxFit?fit;
//   final EdgeInsetsGeometry?padding;
//   final bool isNetworkImage;
//   final VoidCallback?onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(onTap: onPressed,
//       child: Container(
//         width: width,
//         height: height,
//         padding: padding,
//         decoration:BoxDecoration(
//           border: border,
//           borderRadius: BorderRadius.circular(borderRadius),
//           color: backgroundColor,
//         ),
//         child: ClipRRect(borderRadius:
//         applyImageRadius? BorderRadius.circular(borderRadius):BorderRadius.zero,
//           child:  Image(
//               fit:fit,image:isNetworkImage?NetworkImage(imgUrl) :AssetImage(imgUrl)as ImageProvider),),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  const BannerImage({
    super.key,
    this.borderRadius = 15,
    this.width = 300,
    this.height,
    required this.imgUrl,
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor = Colors.transparent,
    this.fit = BoxFit.contain,
    this.padding,
    this.onPressed,
  });

  final double borderRadius;
  final double? width, height;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          child: Image.network(
            imgUrl,  // Use NetworkImage explicitly for network URLs
            fit: fit,
          ),
        ),
      ),
    );
  }
}
