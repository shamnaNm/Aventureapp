import 'package:aventure/screens/event_manager/cerificategenerate.dart';
import 'package:aventure/screens/event_manager/generatecertif.dart';
import 'package:aventure/screens/event_manager/listtickets.dart';
import 'package:aventure/screens/user/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'event_reg.dart';

class CertificateTab extends StatelessWidget {
  const CertificateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true,
              padding: EdgeInsets.all(20),
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.orange,
              labelStyle: TextStyle(color: Colors.white),
              tabs: [
                Text("Generate Certificate"),
                Text("Generated Certificate"),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              PdfListCertificate(),
              CertificateListPage()
            ],
          ),
        ),
      ),
    );
  }
}