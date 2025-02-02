
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBannerPage extends StatefulWidget {
  const AddBannerPage({super.key});

  @override
  State<AddBannerPage> createState() => _AddBannerPageState();
}

class _AddBannerPageState extends State<AddBannerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  var uid;
  bool uploading = false;
  XFile? imageurl;
  var url;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }

  imageFromGallery() async {
    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageurl = _image;
    });
  }

  imageFromCamera() async {
    final XFile? _image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageurl = _image;
    });
  }

  showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                imageFromCamera();
              },
            ),
            ListTile(
              title: Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                imageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  uploadImage() async {
    if (imageurl == null) return;

    setState(() {
      uploading = true;
    });

    try {
      File file = File(imageurl!.path);
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('banners/$filename');
      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      url = await snapshot.ref.getDownloadURL();

      await _firestore.collection('banners').add({
        'image_url': url,
        'uid': uid,
        'uploaded_at': FieldValue.serverTimestamp(),
      });

      setState(() {
        uploading = false;
        imageurl = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Banner uploaded successfully!'),
      ));
    } catch (e) {
      setState(() {
        uploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload banner: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Banners",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,

        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BannerListPage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploading ? null : uploadImage,
        tooltip: 'Add Banner',
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showImagePicker();
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.orange[100],
                ),
                child: imageurl != null
                    ? Image.file(File(imageurl!.path))
                    : Container(
                  color: Colors.white12,
                  child: Icon(
                    Icons.camera_alt,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            uploading
                ? Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }
}

//
//
// class BannerListPage extends StatelessWidget {
//   const BannerListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Banners",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('banners').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           final banners = snapshot.data!.docs;
//
//           return GridView.builder(
//             padding: const EdgeInsets.all(8.0),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 8.0,
//             ),
//             itemCount: banners.length,
//             itemBuilder: (context, index) {
//               var banner = banners[index];
//               var imageUrl = banner['image_url'];
//
//               return Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.orange[100],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
class BannerListPage extends StatelessWidget {
  const BannerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Banners",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('banners').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final banners = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: banners.length,
            itemBuilder: (context, index) {
              var banner = banners[index];
              var imageUrl = banner['image_url'];
              var bannerId = banner.id;

              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange[100],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.orange,size: 30,),
                      onPressed: () async {
                        bool confirmDelete = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete Banner'),
                              content: Text('Are you sure you want to delete this banner?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmDelete) {
                          await FirebaseFirestore.instance.collection('banners').doc(bannerId).delete();
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}