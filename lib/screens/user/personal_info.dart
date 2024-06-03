// import 'package:aventure/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../services/user_service.dart';
// import '../../widgets/apptext.dart';
// import 'dart:io';
// class PersonalInfo extends StatefulWidget {
//   const PersonalInfo({Key? key,}) : super(key: key);
//   @override
//   State<PersonalInfo> createState() => _PersonalInfoState();
// }
// class _PersonalInfoState extends State<PersonalInfo> {
//   late Future<UserModel> _userFuture;
//   List<String> _nationalities = [ 'India', 'USA', 'Japan', 'UAE'];
//   TextEditingController _userController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _ageController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _adrsController = TextEditingController();
//   final _infoKey = GlobalKey<FormState>();
//   File?_image;
//   String? _selectedGender;
//   String? _selectedNationality;
//   String? _selectedExperienceLevel;
//   Future<void> _selectImage() async {
//     final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (imageFile != null) {
//       setState(() {
//         _image = File(imageFile.path);
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         color: Colors.white,
//         child:
//         CustomScrollView(
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: false,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: _selectImage,
//                     child: CircleAvatar(
//                       radius: 45,
//                       backgroundColor: Color(0xffFFF5E9),
//                       child: _image != null
//                           ? ClipOval(
//                         child: Image.file(
//                           _image!,
//                           fit: BoxFit.cover,
//                           width: 90,
//                           height: 90,
//                         ),
//                       )
//                           : Icon(
//                         Icons.camera_alt_sharp,
//                         color: Color(0xffD77272),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Form(
//                     key: _infoKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextFormField(
//                           keyboardType: TextInputType.name,
//                           controller: _userController,
//
//                           cursorColor: Colors.orange,
//
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//
//                             hintText: "Enter Name",
//                             prefixIcon: Icon(Icons.person_3_outlined, color: Colors.orange),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey[300]!, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.orange, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(height: 20),
//                         TextFormField(
//                           keyboardType: TextInputType.emailAddress,
//                           controller: _emailController,
//                           cursorColor: Colors.orange,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: "Enter Email",
//                             prefixIcon: Icon(
//                                 Icons.email_outlined, color: Colors.orange),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.grey[300]!, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.orange, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           keyboardType: TextInputType.phone,
//                           controller: _phoneController,
//                           cursorColor: Colors.orange,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: "Enter Phone no",
//                             prefixIcon: Icon(Icons.phone, color: Colors.orange),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.grey[300]!, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.orange, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           keyboardType: TextInputType.multiline,
//                           controller: _adrsController,
//                           cursorColor: Colors.orange,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: "Address",
//                             prefixIcon: Icon(
//                                 Icons.location_on, color: Colors.orange),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.grey[300]!, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.orange, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           keyboardType: TextInputType.datetime,
//                           controller: _ageController,
//                           cursorColor: Colors.orange,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: "D.O.B",
//                             prefixIcon: Icon(Icons.calendar_today_outlined,
//                                 color: Colors.orange),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.grey[300]!, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.orange, width: 1.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           onTap: () {
//                             _selectDate(context);
//                           },
//                           readOnly: true,
//                         ),
//                         SizedBox(height: 20),
//                         Text("Gender", style: TextStyle(fontSize: 16)),
//                         Row(
//                           children: [
//                             Radio<String>(
//                               value: 'Male',
//                               groupValue: _selectedGender,
//                               activeColor: Colors.orange,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedGender = value;
//                                 });
//                               },
//                             ),
//                             Text("Male"),
//                             Radio<String>(
//                               value: 'Female',
//                               activeColor: Colors.orange,
//                               groupValue: _selectedGender,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedGender = value;
//                                 });
//                               },
//                             ),
//                             Text("Female"),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         DropdownButtonFormField<String>(
//                           value: _selectedNationality,
//                           iconEnabledColor: Colors.orange,
//                           hint: Text('Nationality'),
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedNationality = value;
//                             });
//                           },
//                           items: _nationalities.map((nationality) {
//                             return DropdownMenuItem(
//                               value: nationality,
//                               child: Text(nationality),
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(height: 20),
//                         DropdownButtonFormField<String>(
//                           value: _selectedExperienceLevel,
//                           onChanged: (newValue) {
//                             setState(() {
//                               _selectedExperienceLevel = newValue;
//                             });
//                           },
//                           items: <String>[
//                             'Beginner',
//                             'Intermediate',
//                             'Experienced'
//                           ]
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           decoration: InputDecoration(
//                             labelText: 'Experience Level',
//
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 _showSaveConfirmationDialog();
//                               },
//                               child: Text('Save'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//           )
//       ),
//          );
//   }
//
//   void _showSaveConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Save Changes?"),
//           content: Text("Do you want to save the changes?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _saveChanges();
//                 Navigator.of(context).pop();
//               },
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _saveChanges() {
//     // Implement logic to save changes here
//     print("Changes saved!");
//   }
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         _ageController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//       });
//     }
//   }
// }
import 'dart:io';

import 'package:aventure/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<String> _nationalities = ['India', 'USA', 'Japan', 'UAE'];
  TextEditingController _userController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _adrsController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _infoKey = GlobalKey<FormState>();
  File? _image;
  String? _selectedGender;
  String? _selectedNationality;
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
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
      UserModel userData = UserModel.fromJson(userDoc);
      _selectedGender = userData.gender;
      return userData;
    } else {
      throw Exception("User not logged in");
    }
  }

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: FutureBuilder<UserModel>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    UserModel userData = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _selectImage,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Color(0xffFFF5E9),
                            child: _image != null
                                ? ClipOval(
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                                width: 90,
                                height: 90,
                              ),
                            )
                                : Icon(
                              Icons.camera_alt_sharp,
                              color: Color(0xffD77272),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _infoKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(

                                keyboardType: TextInputType.name,
                                controller: _userController..text=userData.name??'',
                              //  initialValue: userData.name,
                                cursorColor: Colors.orange,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Name",
                                  prefixIcon: Icon(Icons.person_3_outlined, color: Colors.orange),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),SizedBox(height: 20),
                        TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController..text=userData.email??'',
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter Email",
                            prefixIcon: Icon(
                                Icons.email_outlined, color: Colors.orange),
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
                        ),SizedBox(height: 20),
                          TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _phoneController..text=userData.phone??"",
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter Phone no",
                            prefixIcon: Icon(Icons.phone, color: Colors.orange),
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
                          keyboardType: TextInputType.multiline,
                          controller: _adrsController..text=userData.address??"",
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Address",
                            prefixIcon: Icon(
                                Icons.location_on, color: Colors.orange),
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
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "D.O.B",
                            prefixIcon: Icon(Icons.calendar_today_outlined,
                                color: Colors.orange),
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
                          onTap: () {
                            _selectDate(context);
                          },
                          readOnly: true,
                        ),
                        SizedBox(height: 20),
                        Text("Gender", style: TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Male',
                              groupValue: _selectedGender,
                              activeColor: Colors.orange,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                            Text("Male"),
                            Radio<String>(
                              value: 'Female',
                              activeColor: Colors.orange,
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                            Text("Female"),
                          ],
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedNationality,
                          iconEnabledColor: Colors.orange,
                          hint: Text('Nationality'),
                          onChanged: (value) {
                            setState(() {
                              _selectedNationality = value;
                            });
                          },
                          items: _nationalities.map((nationality) {
                            return DropdownMenuItem(
                              value: nationality,
                              child: Text(nationality),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedExperienceLevel,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedExperienceLevel = newValue;
                            });
                          },
                          items: <String>[
                            'Beginner',
                            'Intermediate',
                            'Experienced'
                          ]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Experience Level',

                          ),
                        ),
                        SizedBox(height: 20),   // Add other form fields with initial values from userData
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  _showSaveConfirmationDialog();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Save Changes?"),
          content: Text("Do you want to save the changes?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _saveChanges();
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _saveChanges() {
    // Implement logic to save changes here
    print("Changes saved!");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _ageController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }
}
