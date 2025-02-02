import 'package:aventure/models/activity_model.dart';
import 'package:aventure/models/user_model.dart';
import 'package:aventure/screens/user/paymentpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/medicalInfo_model.dart';
class MedicalInfoPage extends StatefulWidget {
  final MedicalInfo? medicalInfo;
  const MedicalInfoPage({Key? key, this.medicalInfo}) : super(key: key);

  @override
  _MedicalInfoPageState createState() => _MedicalInfoPageState();
}

class _MedicalInfoPageState extends State<MedicalInfoPage> {
  late TextEditingController _bpRateController;
  late TextEditingController _glucoseRateController;
  late TextEditingController _allergiesController;
  late TextEditingController _otherDiseasesController;
  late bool _hasHeartProblem;
  late bool _hasAllergies;
  late bool _hasDisability;

  @override
  void initState() {
    super.initState();
    getData();
    _bpRateController = TextEditingController(text: widget.medicalInfo?.bpRate);
    _glucoseRateController =
        TextEditingController(text: widget.medicalInfo?.glucoseRate);
    _allergiesController =
        TextEditingController(text: widget.medicalInfo?.allergies);
    _otherDiseasesController =
        TextEditingController(text: widget.medicalInfo?.otherDiseases);
    _hasHeartProblem = widget.medicalInfo?.hasHeartProblem ?? false;
    _hasAllergies = widget.medicalInfo?.hasAllergies ?? false;
    _hasDisability = widget.medicalInfo?.hasDisability ?? false;

  }
  var uid;
  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final ActivityModel activity = args['activity'];

    final DateTime? selectedDate = args['selectedDate'];
    final String? selectedTime = args['selectedTime'];
    final int ticketsSelected = args['ticketsSelected'];
    final double totalAmount = args['totalAmount'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Health Info', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(

          children: [
           // Text('(Its optional,you can skip)'),
            TextFormField(
              controller: _bpRateController,
              decoration: InputDecoration(labelText: 'Blood Pressure Rate'),
            ),
            TextFormField(
              controller: _glucoseRateController,
              decoration: InputDecoration(labelText: 'Glucose Rate'),
            ),
            CheckboxListTile(
              title: Text('Do you have any heart problem?'),
              value: _hasHeartProblem,
              onChanged: (value) {
                setState(() {
                  _hasHeartProblem = value!;
                });
              },
            ),
            _hasHeartProblem
                ? TextFormField(
              decoration: InputDecoration(labelText: 'Specify heart problem'),
            )
                : SizedBox(),
            CheckboxListTile(
              title: Text('Do you have any allergies?'),
              value: _hasAllergies,
              onChanged: (value) {
                setState(() {
                  _hasAllergies = value!;
                });
              },
            ),
            _hasAllergies
                ? TextFormField(
              controller: _allergiesController,
              decoration: InputDecoration(labelText: 'Specify allergies'),
            )
                : SizedBox(),
            TextFormField(
              controller: _otherDiseasesController,
              decoration: InputDecoration(labelText: 'Any other diseases?'),
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('Do you have any Disability problem?'),
              value: _hasDisability,
              onChanged: (value) {
                setState(() {
                  _hasDisability = value!;
                });
              },
            ),
            _hasDisability
                ? TextFormField(
              decoration: InputDecoration(labelText: 'Specify disability'),
            )
                : SizedBox(),
            SizedBox(height: 20),
        ElevatedButton(
          // onPressed: () {
          //   showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         title: Text('Confirm Booking'),
          //         content: Text('Are you sure you want to save this information?'),
          //         actions: <Widget>[
          //           TextButton(
          //             onPressed: () {
          //               Navigator.of(context).pop(); // Cancel saving
          //             },
          //             child: Text('Cancel'),
          //           ),
          //           TextButton(
          //             onPressed: () {
          //               Navigator.of(context).pop(); // Close dialog
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => PaymentPage(),
          //                   settings: RouteSettings(
          //                     arguments: {
          //                       'activity': activity,
          //                       'selectedDate': selectedDate,
          //                       'selectedTime': selectedTime,
          //                       'ticketsSelected': ticketsSelected,
          //                       'totalAmount': totalAmount,
          //                       'medicalInfo': {
          //                         'bpRate': _bpRateController.text,
          //                         'glucoseRate': _glucoseRateController.text,
          //                         'allergies': _allergiesController.text,
          //                         'otherDiseases': _otherDiseasesController.text,
          //                         'hasHeartProblem': _hasHeartProblem,
          //                         'hasAllergies': _hasAllergies,
          //                         'hasDisability': _hasDisability,
          //                       },
          //                     },
          //                   ),
          //                 ),
          //               );
          //             },
          //
          //
          //
          //             child: Text('Confirm'),
          //           ),
          //         ],
          //       );
          //     },
          //   );
          // },
          //
          // child: Text('Next'),

            onPressed: () {
              // Check if any condition exists
              if (_hasHeartProblem || _hasAllergies || _hasDisability || _otherDiseasesController.text.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Booking Not Allowed'),
                      content: Text('You cannot book this activity due to your medical condition.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Proceed to Payment Page if no conditions exist
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Booking'),
                      content: Text('Are you sure you want to save this information?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Cancel saving
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(),
                                settings: RouteSettings(
                                  arguments: {
                                    'activity': activity,
                                    'selectedDate': selectedDate,
                                    'selectedTime': selectedTime,
                                    'ticketsSelected': ticketsSelected,
                                    'totalAmount': totalAmount,
                                    'medicalInfo': {
                                      'bpRate': _bpRateController.text,
                                      'glucoseRate': _glucoseRateController.text,
                                      'allergies': _allergiesController.text,
                                      'otherDiseases': _otherDiseasesController.text,
                                      'hasHeartProblem': _hasHeartProblem,
                                      'hasAllergies': _hasAllergies,
                                      'hasDisability': _hasDisability,
                                    },
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Next'),
          ),

          ],
        ),
      ),
    );
  }
}
