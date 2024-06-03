import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AddBannerPage extends StatefulWidget {
  const AddBannerPage({super.key});

  @override
  State<AddBannerPage> createState() => _AddBannerPageState();
}

class _AddBannerPageState extends State<AddBannerPage> {


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( title: Text(
        "Add Banners",
        style: TextStyle(color: Colors.white),
      ),
        centerTitle: false,

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      } ,tooltip: 'Add Banner',
        child: Icon(Icons.add),),
    );
  }
}
