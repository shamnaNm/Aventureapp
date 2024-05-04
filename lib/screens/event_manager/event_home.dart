import 'package:flutter/material.dart';


class EventManagerHome extends StatefulWidget {
  const EventManagerHome({super.key});

  @override
  State<EventManagerHome> createState() => _EventManagerHomeState();
}

class _EventManagerHomeState extends State<EventManagerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,

color: Colors.lime,
      ),
    );
  }
}
