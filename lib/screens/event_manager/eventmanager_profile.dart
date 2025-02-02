
import 'dart:io';
import 'package:aventure/models/eventmanager_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// Import your EventManager model

class EventersProfile extends StatefulWidget {
  const EventersProfile({Key? key}) : super(key: key);

  @override
  _EventersProfileState createState() => _EventersProfileState();
}

class _EventersProfileState extends State<EventersProfile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var uid;
  EventManager? eventManager;
  File? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _aboutCompanyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    uid = _auth.currentUser!.uid;

    DocumentSnapshot doc = await _firestore.collection('eventmanager').doc(uid).get();
    eventManager = EventManager.fromJson(doc);

    setState(() {
      _nameController.text = eventManager?.name ?? '';
      _emailController.text = eventManager?.email ?? '';
      _phoneController.text = eventManager?.phone ?? '';
      _companyNameController.text = eventManager?.companyname ?? '';
      _qualificationController.text = eventManager?.qualification ?? '';
      _aboutCompanyController.text = eventManager?.description ?? '';
    });
  }

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName = 'user_images/${_auth.currentUser!.uid}.jpg';
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _saveProfile() async {
    if (uid == null) return;

    String? imageUrl;
    if (_image != null) {
      imageUrl = await _uploadImage(_image!);
    }

    eventManager = EventManager(
      id: uid,
      email: _emailController.text,
      password: eventManager!.password,
      name: _nameController.text,
      phone: _phoneController.text,
      companyname: _companyNameController.text,
      qualification: _qualificationController.text,
      role: eventManager!.role,
      status: eventManager!.status,
      description: _aboutCompanyController.text,
      img: imageUrl ?? eventManager!.img,
    );

    await _firestore.collection('eventmanager').doc(uid).update(eventManager!.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Eventers Profile',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _selectImage,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : eventManager?.img != null && eventManager!.img!.isNotEmpty
                          ? NetworkImage(eventManager!.img!) as ImageProvider
                          : null,
                      child: (_image == null && (eventManager?.img == null || eventManager!.img!.isEmpty))
                          ? Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 45,
                      )
                          : null,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Update Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _qualificationController,
                decoration: InputDecoration(
                  labelText: 'Qualification',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _aboutCompanyController,
                decoration: InputDecoration(
                  labelText: 'About Company',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
