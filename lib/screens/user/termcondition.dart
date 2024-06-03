import 'package:flutter/material.dart';


class TermsConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Terms and Conditions',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to Aventure!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'These terms and conditions outline the rules and regulations for the use of Aventure\'s App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'By accessing this app we assume you accept these terms and conditions. Do not continue to use Aventure if you do not agree to take all of the terms and conditions stated on this page.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'User Accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'To access certain features of the app, you may be required to create an account. You must provide accurate and complete information and keep your account information updated. You are solely responsible for the activity that occurs on your account.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Event Booking and Payments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'All bookings made through the app are subject to availability and confirmation. Payment must be made at the time of booking. We accept various payment methods as listed on the app. In case of any issues with the payment, please contact our support team.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Cancellations and Refunds',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Cancellations and refunds are subject to the terms and conditions of the specific activity provider. Please review the cancellation policy before making a booking.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'User Conduct',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You agree to use the app only for lawful purposes. You must not use the app in any way that causes, or may cause, damage to the app or impairment of the availability or accessibility of the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Liability',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We are not liable for any loss or damage arising from your use of the app or any bookings made through the app. Your participation in any adventure activities is at your own risk.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Changes to Terms and Conditions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We may update our terms and conditions from time to time. We will notify you of any changes by posting the new terms and conditions on this page.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you have any questions about these Terms and Conditions, please contact us at support@aventure.com.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
