import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';



import '../user/user_register_page.dart';
import 'event_reg.dart';

class RegisterTab extends StatelessWidget {
  const RegisterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true,
              padding: EdgeInsets.all(20),
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.orange,
              labelStyle: TextStyle(color: Colors.white),
              tabs: [
                Text("User Registration"),
                Text("Eventmanager Registration"),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              RegisterPage(),
             EventManagerRegisterPage(),


            ],
          ),
        ),
      ),
    );
  }
}