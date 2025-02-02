import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomPage extends StatelessWidget {
  final String imageUrl;

  const ImageZoomPage({Key? key, required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile Image",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: Colors.black,
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
