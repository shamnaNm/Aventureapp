import 'package:image_picker/image_picker.dart';

import 'banner_model.dart';

// class BannerService {
//   // Simulated method to fetch banners
//   static Future<List<BannerModel>> fetchBanners() async {
//     // Simulated delay to mimic network request
//     await Future.delayed(Duration(seconds: 2));
//
//     // Mocked banner URLs
//     List<String> bannerUrls = [
//       'assets/img/banner.png',
//       'assets/img/banner.png',
//       'assets/img/banner.png',
//     ];
//
//     // Map URLs to BannerModel objects
//     List<BannerModel> banners = bannerUrls.map((url) => BannerModel(imageUrl: url)).toList();
//
//     return banners;
//   }
// }
import 'dart:io'; // Import this for File class
import 'dart:convert';

import 'package:http/http.dart' as http;

class BannerService {
  // Simulated method to fetch banners
  static Future<List<BannerModel>> fetchBanners() async {
    // Simulated delay to mimic network request
    await Future.delayed(Duration(seconds: 2));

    // Mocked banner URLs
    List<String> bannerUrls = [
      'assets/img/banner.png',
      'assets/img/banner.png',
      'assets/img/banner.png',
    ];

    // Map URLs to BannerModel objects
    List<BannerModel> banners = bannerUrls.map((url) => BannerModel(imageUrl: url)).toList();

    return banners;
  }


  // Method to add a banner from the gallery
  static Future<String?> addBannerFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Return the path of the selected image file
      return pickedFile.path;
    }
    // Return null if no image was selected
    return null;
  }

  static Future<bool> uploadImage(String imagePath) async {
    try {
      // Read the file as bytes
      File imageFile = File(imagePath);
      List<int> imageBytes = await imageFile.readAsBytes();

      // Encode image bytes to base64
      String base64Image = base64Encode(imageBytes);

      // Prepare your API endpoint for image upload
      String apiUrl = 'https://example.com/upload'; // Replace with your actual API endpoint

      // Make HTTP POST request to upload image
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: {'image': base64Image},
      );

      // Check if the upload was successful (you might need to adjust this based on your API response)
      if (response.statusCode == 200) {
        return true; // Upload successful
      } else {
        return false; // Upload failed
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false; // Upload failed
    }
  }
}