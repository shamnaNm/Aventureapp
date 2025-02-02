import 'package:aventure/screens/admin/userabout.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserService _userService = UserService(); // Initialize your user service
  late Future<List<UserModel>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _userService.getAllUsers();
  }
  Future<void> _deleteUser(String userId) async {
    try {
      await _userService.deleteUser(userId);
      // Refresh user list after deletion
      setState(() {
        _usersFuture = _userService.getAllUsers();
      });
    } catch (e) {
      // Handle error
      print('Error deleting user: $e');
    }
  } Future<void> _showDeleteConfirmationDialog(String userId, String userName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete $userName?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _deleteUser(userId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Users", style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                future: _usersFuture,
                builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        UserModel user = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Dismissible(
                            key: UniqueKey(), // Provide a unique key for each Dismissible
                            onDismissed: (direction) {
                              // Delete the user when dismissed
                              _deleteUser(user.uid!);
                            },
                            background: Container(
                                color: Colors.grey), // Add background color when swiping
                              child: ListTile(
                                tileColor: Colors.grey.withOpacity(0.1),
                                title: Text(user.name ?? ''),
                                subtitle: Text(user.email ?? ''),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Trigger deletion when delete button is pressed
                                    _showDeleteConfirmationDialog(user.uid!, user.name ?? '');
                                  },
                                ),
                                onTap: () {
                                  // Navigate to UserDetailsPage on tap
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserDetailsPage(user: user),
                                    ),
                                  );
                                },

                              ),

                            

                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}