
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/activity_model.dart';
import '../../services/activityService.dart';
class EditActivityPage extends StatefulWidget {
  final ActivityModel activity;
  EditActivityPage({required this.activity});
  @override
  _EditActivityPageState createState() => _EditActivityPageState();
}
class _EditActivityPageState extends State<EditActivityPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var uid;


  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  final ActivityService _activityService = ActivityService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _eventerController = TextEditingController();
  final TextEditingController _sealevelController = TextEditingController();
  String? _selectedCategory;
  List<Map<String, dynamic>> _schedules = [];
  final TextEditingController _scheduleTimeController = TextEditingController();
  final TextEditingController _ticketsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.activity.title ?? '';
    _locationController.text = widget.activity.location ?? '';
    _priceController.text = widget.activity.price?.toString() ?? '';
    _durationController.text = widget.activity.duration ?? '';
    _weightController.text = widget.activity.weight ?? '';
    _imageController.text = widget.activity.image ?? '';
    _descriptionController.text = widget.activity.description ?? '';
    _eventerController.text = widget.activity.eventer ?? '';
    _sealevelController.text = widget.activity.sealevel ?? '';
    _selectedCategory = widget.activity.category;
    _schedules = List.from(widget.activity.schedules as Iterable);
    getData();
  }

  void _saveActivity() async {
    String title = _titleController.text;
    String location = _locationController.text;
    double? price = double.tryParse(_priceController.text);
    String duration = _durationController.text;
    String weight = _weightController.text;
    String image = _imageController.text;
    String description = _descriptionController.text;
    String eventer = _eventerController.text;
    String sealevel = _sealevelController.text;
    String? category = _selectedCategory;

    if (title.isNotEmpty && location.isNotEmpty && price != null) {
      ActivityModel updatedActivity = ActivityModel(
        title: title,
        id: widget.activity.id,
        location: location,
        price: price,
        duration: duration,
        weight: weight,
        image: image,
        description: description,
        eventer: eventer,
        sealevel: sealevel,
        category: category,
        schedules: _schedules,
      );
      await _activityService.updateActivity(widget.activity.id!, updatedActivity);
      Navigator.pop(context);
    }
  }
  void _addSchedule() {
    if (_scheduleTimeController.text.isNotEmpty && _ticketsController.text.isNotEmpty) {
      setState(() {
        _schedules.add({
          'time': _scheduleTimeController.text,
          'tickets': int.parse(_ticketsController.text),
        });
        _scheduleTimeController.clear();
        _ticketsController.clear();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Activity',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveActivity,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price in Rupees',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duration in Hours',
                ),
              ),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Restricted Weight',
                ),
              ),
              TextField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              TextField(
                controller: _eventerController,
                decoration: InputDecoration(
                  labelText: 'EventerName/CompanyName',
                ),
              ),
              TextField(
                controller: _sealevelController,
                decoration: InputDecoration(
                  labelText: 'Height above SeaLevel',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _scheduleTimeController,
                decoration: InputDecoration(
                  labelText: 'Schedule Time',
                ),
              ),
              TextField(
                controller: _ticketsController,
                decoration: InputDecoration(
                  labelText: 'Number of Tickets',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addSchedule,
                child: Text('Add Schedule'),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _schedules.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Time: ${_schedules[index]['time']}'),
                      subtitle: Text('Tickets: ${_schedules[index]['tickets']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _schedules.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
