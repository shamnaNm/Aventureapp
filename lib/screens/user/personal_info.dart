
import 'dart:io';
import 'package:aventure/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late Future<UserModel> _userFuture;
  TextEditingController _userController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _adrsController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  final _infoKey = GlobalKey<FormState>();
  File? _image;
  String? _selectedGender;
  String? _selectedExperienceLevel;

  @override
  void initState() {
    super.initState();
    _userFuture = _getUserData();
  }

  Future<UserModel> _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      UserModel userData = UserModel.fromJson(userDoc);
      _selectedGender = userData.gender;
      _selectedExperienceLevel = userData.experienceLevel;
      _adrsController.text = userData.address ?? "";
      _nationalityController.text = userData.nationality ?? "";

      return userData;
    } else {
      throw Exception("User not logged in");
    }
  }

  Future<void> _selectImage() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName =
        'user_images/${FirebaseAuth.instance.currentUser!.uid}.jpg';
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _updateUserData(UserModel user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      user.uid = currentUser.uid;
      user.name = _userController.text;
      user.phone = _phoneController.text;
      user.address = _adrsController.text;
      user.gender = _selectedGender;
      user.nationality = _nationalityController.text;
      user.experienceLevel = _selectedExperienceLevel;
      if (_image != null) {
        user.imgUrl = await _uploadImage(_image!);
      }
      await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUser.uid)
          .update(user.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User details updated successfully")));
    } else {
      throw Exception("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: AppBarClipper(),
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(55),
                    bottomLeft: Radius.circular(55)),
                gradient: LinearGradient(
                  colors: [Colors.orange.withOpacity(0.6), Colors.orange],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          FutureBuilder<UserModel>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                UserModel userData = snapshot.data!;
                return Column(
                  children: [
                    SizedBox(height: 150),
                    GestureDetector(
                      onTap: _selectImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.orange[200],
                        child: _image != null
                            ? ClipOval(
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : (userData.imgUrl != null &&
                                    userData.imgUrl!.isNotEmpty)
                                ? ClipOval(
                                    child: Image.network(
                                      userData.imgUrl!,
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _infoKey,
                          child: ListView(
                            children: [
                              Center(
                                child: Text(
                                  "${userData.name!}'s Profile",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _userController
                                  ..text = userData.name ?? '',
                                cursorColor: Colors.orangeAccent,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter User Name",
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors.orangeAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orangeAccent, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController
                                  ..text = userData.email ?? '',
                                cursorColor: Colors.orangeAccent,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Email",
                                  prefixIcon: Icon(Icons.email_outlined,
                                      color: Colors.orangeAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orangeAccent, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: _phoneController
                                  ..text = userData.phone ?? "",
                                cursorColor: Colors.orangeAccent,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter your 10 Digit Mobile Number",
                                  prefixIcon: Icon(Icons.phone,
                                      color: Colors.orangeAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orangeAccent, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                controller: _adrsController
                                  ..text = userData.address ?? "",
                                cursorColor: Colors.orangeAccent,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Address",
                                  prefixIcon: Icon(Icons.location_on,
                                      color: Colors.orangeAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: _ageController,
                                cursorColor: Colors.orangeAccent,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "DD / MM / YYYY",
                                  prefixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.orangeAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orangeAccent, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text("Male"),
                                      value: "male",
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text("Female"),
                                      value: "female",
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _nationalityController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.orangeAccent,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Nationality",
                                  prefixIcon: Icon(
                                    Icons.flag,
                                    color: Colors.orangeAccent,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Experience Level",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              RadioListTile(
                                title: Text("Beginner"),
                                value: "beginner",
                                groupValue: _selectedExperienceLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedExperienceLevel = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: Text("Intermediate"),
                                value: "intermediate",
                                groupValue: _selectedExperienceLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedExperienceLevel = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: Text("Advanced"),
                                value: "advanced",
                                groupValue: _selectedExperienceLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedExperienceLevel = value.toString();
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                ),
                                onPressed: () async {
                                  if (_infoKey.currentState!.validate()) {
                                    try {
                                      await _updateUserData(userData);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Failed to update user details: $e")));
                                    }
                                  }
                                },
                                child: Text("Save",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No user data available'));
              }
            },
          ),
        ],
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - 80, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

extension on UserModel {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'gender': gender,
      'nationality': nationality,
      'experienceLevel': experienceLevel,
      'imgUrl': imgUrl
    };
  }

  static UserModel fromJson(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      name: doc['name'],
      email: doc['email'],
      phone: doc['phone'],
      address: doc['address'],
      gender: doc['gender'],
      nationality: doc['nationality'],
      experienceLevel: doc['experienceLevel'],
      imgUrl: doc['imgUrl'],
    );
  }
}
