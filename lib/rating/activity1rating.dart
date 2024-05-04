import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomRatingBarIndicator extends StatelessWidget {
  const CustomRatingBarIndicator({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (index) => Icon(
          index < rating ? Iconsax.star1 : Iconsax.star2,
          color: Colors.yellow,
          size: 20,
        ),
      ),
    );
  }
}

// class RatingBarIndicator extends StatelessWidget {
//   const RatingBarIndicator({
//     Key? key,
//     required this.rating,
//   }) : super(key: key);
//
//   final double rating;
//
//   @override
//
//   Widget build(BuildContext context) {
//     return RatingBarIndicator(
//       // rating: rating,
//         5,
//     (index) => Icon(
//       index < rating ? Iconsax.star1 : Iconsax.star2,
//       color: Colors.yellow,
//       size: 20,
//       // itemSize: 20,
//       //
//       // itemBuilder: (_, __) => Icon(Iconsax.star1,color: Colors.yellow,),
//         );
//   }
// }