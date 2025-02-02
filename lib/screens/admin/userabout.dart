import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  const UserDetailsPage({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(user.name ?? 'User Details',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.network( user.imgUrl ?? '',height: 150,width: 150,),
              //   ],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user.imgUrl != null && user.imgUrl!.isNotEmpty
                      ? Image.network(
                    user.imgUrl!,
                    height: 150,
                    width: 150,
                  )
                      : Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        'Image not available',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Name: ${user.name ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${user.email ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: ${user.phone ?? ''}',
                style: TextStyle(fontSize: 18),
              ), SizedBox(height: 10),
              Text(
                'Address: ${user.address ?? ''}',
                style: TextStyle(fontSize: 18),
              ), SizedBox(height: 10),
              Text(
                'Gender: ${user.gender ?? ''}',
                style: TextStyle(fontSize: 18),
              ), SizedBox(height: 10),
              Text(
                'Nationality: ${user.nationality ?? ''}',
                style: TextStyle(fontSize: 18),
              ),SizedBox(height: 10),
              Text(
                'ExperienceLevel: ${user.experienceLevel ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
