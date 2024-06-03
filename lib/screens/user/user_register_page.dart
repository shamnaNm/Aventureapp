import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  String? uid;
  bool visibile = true;
  final _regKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> roles = [
    'user',
    'eventmanager',
  ];
  String? selectedRole;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userController.dispose();
    super.dispose();
  }
  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully registered!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Form(
          key: _regKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: themeData.textTheme.displayLarge,
                      textScaler: TextScaler.noScaling,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is mandatory";
                        }
                        RegExp regex = RegExp(r'^[a-zA-Z ]+$');
                        if (!regex.hasMatch(value)) {
                          return "Invalid formate , Use valid username.";
                        }
                        return null;
                      },
                      controller: _userController,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        filled: true, // Set filled property to true
                        fillColor: Colors.grey[200],

                        hintText: "UserName",


                        hintStyle: themeData.textTheme.labelSmall,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.2,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.orange,
                              width: 1.2,
                            )),

                        prefixIcon: Icon(Icons.person, color: Colors.orange),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is mandatory";
                        }
                        else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;

                      },

                      controller: _emailController,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        filled: true, // Set filled property to true
                        fillColor: Colors.grey[200],
                        hintText: "Email",



                        hintStyle: themeData.textTheme.labelSmall,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.2,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.orange,
                              width: 1.2,
                            )),

                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is mandatory";
                        }
                        if (value!.length < 6) {
                          return "Password should be atleast  6 characters";
                        }

                        return null;
                      },
                      obscureText: visibile,
                      controller: _passwordController,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                          filled: true, // Set filled property to true
                          fillColor: Colors.grey[200],
                          // contentPadding: EdgeInsets.only(left:20,top: 25,bottom: 25),
                          hintText: "Password",
                          hintStyle: themeData.textTheme.labelSmall,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[200]!,
                              width: 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.orange,
                                width: 1.2,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.2,
                              )),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.orange,
                          ),
                          suffixIcon: IconButton(
                            color: Colors.orange,
                            onPressed: () {
                              setState(() {
                                visibile = !visibile;
                              });
                            },
                            icon: visibile == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (_regKey.currentState!.validate()) {
                            try {
                              UserModel user = UserModel(
                                  role: "user",
                                  phone: "",
                                  address: "",
                                    imgUrl: "",
                                    gender: "",
                                  nationality: "",
                                  experienceLevel: "",
                                  name: _userController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  createdAt: DateTime.now(),
                                  uid: uid,
                                  status: 1);

                              UserService userService = UserService();
                              final res =
                              await userService.registerUser(user);

                              if (res == "") {
                                _showSuccessMessage();
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              }
                            } on FirebaseAuthException catch (e) {
                              // Handle FirebaseAuthException here
                              print('Firebase Auth Exception: ${e.message}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "Firebase Auth Error: ${e.message}"),
                                ),
                              );
                            } catch (e) {
                              // Catch any other type of exception
                              print('Error: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Error: $e"),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          height: 55,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Text(
                                " Create Account",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ?"),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
