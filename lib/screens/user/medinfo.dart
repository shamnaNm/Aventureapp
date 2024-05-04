// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => MedicalInfoPage(medicalInfo: widget.medicalInfo),
// ),
// );
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
    _bpRateController = TextEditingController(text: widget.medicalInfo?.bpRate);
    _glucoseRateController = TextEditingController(text: widget.medicalInfo?.glucoseRate);
    _allergiesController = TextEditingController(text: widget.medicalInfo?.allergies);
    _otherDiseasesController = TextEditingController(text: widget.medicalInfo?.otherDiseases);
    _hasHeartProblem = widget.medicalInfo?.hasHeartProblem ?? false;
    _hasAllergies = widget.medicalInfo?.hasAllergies ?? false;
    _hasDisability=widget.medicalInfo?.hasDisability ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Medical Information')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
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

            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                // Save medical info
                // Navigator.pop(context, MedicalInfo(
                //   bpRate: _bpRateController.text,
                //   glucoseRate: _glucoseRateController.text,
                //   hasHeartProblem: _hasHeartProblem,
                //   hasAllergies: _hasAllergies,
                //   allergies: _allergiesController.text,
                //   otherDiseases: _otherDiseasesController.text,
                // ));
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
