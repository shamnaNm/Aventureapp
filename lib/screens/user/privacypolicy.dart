import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Privacy Policy',style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(


        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Effective Date: [16-05-2024]',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'This Privacy Policy explains how [AventureCo] ("we", "us", or "our") collects, uses, discloses, and protects your information when you use our [Aventure] mobile application (the "Service").',
              ),
              SizedBox(height: 20.0),
              Text(
                'Information Collection and Use',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We do not collect any personally identifiable information from users of our Service.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Log Data',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We do not collect log data when you use our Service.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Cookies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We do not use cookies in connection with our Service.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Service Providers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We do not employ third-party companies or individuals to facilitate our Service.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We take reasonable precautions to protect the information you provide when you use our Service. However, please be aware that no method of transmission over the internet or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Links to Other Sites',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Our Service does not contain links to other sites.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Children\'s Privacy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Our Service does not address anyone under the age of 13 ("Children").',
              ),
              SizedBox(height: 20.0),
              Text(
                'Changes to This Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We may update our Privacy Policy from time to time. Thus, we advise you to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at [aventure@gmail.com].',
              ),
            ],
          ),
        ),
      ),
    );
  }
}