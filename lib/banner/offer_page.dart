
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/sliderhomebanner.dart';
class BannerSection extends StatefulWidget {
  const BannerSection({super.key});
  @override
  State<BannerSection> createState() => _BannerSectionState();
}
class _BannerSectionState extends State<BannerSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MyPromoSlider(banners: ['assets/img/banner.png','assets/img/banner.png','assets/img/banner.png'],),
      ),
    );
  }
}