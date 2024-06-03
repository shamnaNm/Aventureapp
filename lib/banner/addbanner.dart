
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../widgets/banner.dart';
import '../widgets/sliderhomebanner.dart';
import 'banner_model.dart';
import 'banner_service.dart';
import 'package:flutter/material.dart';
// Import the image_picker package


import '../widgets/banner.dart';

class AddBannerSection extends StatefulWidget {
  const AddBannerSection({Key? key}) : super(key: key);

  @override
  State<AddBannerSection> createState() => _AddBannerSectionState();
}

class _AddBannerSectionState extends State<AddBannerSection> {
  late Future<List<BannerModel>> _bannerFuture;

  @override
  void initState() {
    super.initState();
    _bannerFuture = BannerService.fetchBanners();
  }

  // Function to handle adding banners from gallery
  Future<void> _addBannerFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Upload the image and update UI
      bool uploaded = await BannerService.uploadImage(pickedFile.path);
      if (uploaded) {
        // If the image is uploaded successfully, refresh the banner list
        setState(() {
          _bannerFuture = BannerService.fetchBanners();
        });
      } else {
        // Handle upload failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<BannerModel>>(
          future: _bannerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No banners available.'),
              );
            } else {
              return MyPromoSlider(
                banners: snapshot.data!.map((banner) => banner.imageUrl).toList(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBannerFromGallery,
        tooltip: 'Add Banner',
        child: Icon(Icons.add),
      ),
    );
  }
}