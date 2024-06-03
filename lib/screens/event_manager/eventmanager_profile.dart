import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class EventersProfile extends StatefulWidget {
  const EventersProfile({Key? key}) : super(key: key);
  @override
  _EventersProfileState createState() => _EventersProfileState();
}
class _EventersProfileState extends State<EventersProfile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var uid;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _companyAddressController = TextEditingController();
  TextEditingController _companyPhoneNumberController = TextEditingController();
  TextEditingController _aboutCompanyController = TextEditingController();

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
                  CircleAvatar(
                    radius: 30,
                    // Placeholder image or user's profile picture can be added here
                    backgroundImage: AssetImage('assets/img/profile.png'),
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
                  labelText: 'Eventer Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
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
                controller: _companyAddressController,
                decoration: InputDecoration(
                  labelText: 'Company Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _companyPhoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Company Phone Number',
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
                onPressed: () {
                  // Save button action
                  // _saveProfile();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
