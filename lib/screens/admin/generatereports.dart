import 'package:flutter/material.dart';
class GenerateReports extends StatefulWidget {
  const GenerateReports({super.key});

  @override
  State<GenerateReports> createState() => _GenerateReportsState();
}

class _GenerateReportsState extends State<GenerateReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.orange,
          title: Text(
            "Reports",style: TextStyle(
            color: Colors.white
          ),
          ),
        ),
    );
  }
}
