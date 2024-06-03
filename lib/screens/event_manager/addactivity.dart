import 'dart:io';

import 'package:aventure/models/category_model.dart';
import 'package:aventure/services/category_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../models/activity_model.dart';
import '../../services/activityService.dart';
import 'allcreatedactivity.dart';
class ActivityManager extends StatefulWidget {
  @override
  _ActivityManagerState createState() => _ActivityManagerState();
}
class _ActivityManagerState extends State<ActivityManager> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var uid;


  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  final ActivityService _activityService = ActivityService();
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _eventerController = TextEditingController();
  final TextEditingController _sealevelController = TextEditingController();
  final TextEditingController _scheduleTimeController = TextEditingController();
  final TextEditingController _ticketsController = TextEditingController();
  bool uploading = false;
  List<CategoryModel> categoryList = [];
  String? selectedCategory;
  List<Map<String, dynamic>> schedules = [];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _fetchCategories();
    getData();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await _categoryService.getCategories().first;
      setState(() {
        categoryList = categories;
        if (categoryList.isNotEmpty) {
          selectedCategory = categoryList[0].title; // Set initial value
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _addActivity() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        uploading = true;
      });
      var id = Uuid().v1();
      String title = _titleController.text;
      String location = _locationController.text;
      double price = double.parse(_priceController.text);
      String duration = _durationController.text;
      String weight = _weightController.text;
      String image = _imageController.text;
      String description = _descriptionController.text;
      String eventer = _eventerController.text;
      String sealevel = _sealevelController.text;
      ActivityModel activity = ActivityModel(
        id: id,
        title: title,
        location: location,
        price: price,
        duration: duration,
        weight: weight,
        image: image,
        description: description,
        eventer: eventer,
        sealevel: sealevel,
        category: selectedCategory,
        schedules: schedules,
        eventManagerId: uid
      );
      bool? res = await _activityService.addActivity(activity, imageurl!);
      _titleController.clear();
      _locationController.clear();
      _priceController.clear();
      _durationController.clear();
      _weightController.clear();
      _imageController.clear();
      _descriptionController.clear();
      _eventerController.clear();
      _sealevelController.clear();
      setState(() {
        schedules.clear();
      });

      if (res == true) {
        setState(() {
          uploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('New activity added: $title'),
            duration: Duration(seconds: 3), // Duration to show the snackbar
          ),
        );
        // Navigate to all created activities page
        _navigateToAllCreatedActivitiesPage();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AllCreatedActivitiesPage(),
        //   ),
        // );
      }
    }
  }
  void _navigateToAllCreatedActivitiesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllCreatedActivitiesPage(),
      ),
    );
  }
  var filename;
  XFile? imageurl;
  var url;
  final ImagePicker _picker = ImagePicker();

  void _addSchedule() {
    if (_scheduleTimeController.text.isNotEmpty && _ticketsController.text.isNotEmpty) {
      setState(() {
        schedules.add({
          'time': _scheduleTimeController.text,
          'tickets': int.parse(_ticketsController.text),
        });
        _scheduleTimeController.clear();
        _ticketsController.clear();
      });
    }  }

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
                imageFromCamera();
              },
            ),
            ListTile(
              title: Text("Gallery"),
              onTap: () {
                imageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Activity Manager',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _navigateToAllCreatedActivitiesPage,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                        DropdownButton<String>(
                          value: selectedCategory,
                          hint: Text('Select Category'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue!;
                            });
                          },
                          items: categoryList.map((CategoryModel category) {
                            return DropdownMenuItem<String>(
                              value: category.title,
                              child: Text(category.title!),
                            );
                          }).toList(),
                        ),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            labelText: 'Location',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a location';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: 'Price in Rupees',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a price';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _durationController,
                          decoration: InputDecoration(
                            labelText: 'Duration in Hours',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a duration';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _weightController,
                          decoration: InputDecoration(
                            labelText: 'Restricted Weight',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a weight restriction';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _eventerController,
                          decoration: InputDecoration(
                            labelText: 'Eventer Name/Company Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an eventer or company name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _sealevelController,
                          decoration: InputDecoration(
                            labelText: 'Height above Sea Level',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the height above sea level';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _scheduleTimeController,
                          decoration: InputDecoration(
                            labelText: 'Schedule Time',
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter a schedule time';
                          //   }
                          //   return null;
                          // },
                        ),
                        TextFormField(
                          controller: _ticketsController,
                          decoration: InputDecoration(
                            labelText: 'Number of Tickets',
                          ),
                          keyboardType: TextInputType.number,
                         // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter the number of tickets';
                          //   }
                          //   if (int.tryParse(value) == null) {
                          //     return 'Please enter a valid number';
                          //   }
                          //   return null;
                          // },
                        ),
                        ElevatedButton(
                          onPressed: _addSchedule,
                          child: Text('Add Schedule'),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: schedules.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Time: ${schedules[index]['time']}'),
                              subtitle: Text('Tickets: ${schedules[index]['tickets']}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    schedules.removeAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: _addActivity,
                          child: Text('Add Activity'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            visible: uploading,
          )
        ],
      ),
    );
  }
}
