import 'package:aventure/screens/common/forgotpage.dart';
import 'package:aventure/screens/event_manager/reg_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aventure/screens/user/user_register_page.dart';
import 'package:iconsax/iconsax.dart';
import '../../services/auth_services.dart';
import '../../services/user_service.dart';
import '../user/home_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _checked = false;
  bool visibile = true;
  final _loginKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully Logged in!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            Image.asset(
              'assets/img/aventurelogo.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
            key: _loginKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " Welcome Back !  ",
                        style: themeData.textTheme.displayLarge,
                        textScaler: TextScaler.noScaling,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "    Enter the log in details ",
                        style: themeData.textTheme.displaySmall,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is mandatory";
                          }
                        },
                        controller: _emailController,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          filled: true,
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
                            ),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.orange),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
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
                            hintText: "Password",
                            hintStyle: themeData.textTheme.labelSmall,
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
                                  color: Colors.white,
                                  width: 1.2,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.2,
                                )),
                            prefixIcon: Icon(Icons.lock, color: Colors.orange),
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
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>ForgotPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password ?",
                              style: themeData.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (_loginKey.currentState!.validate()) {
                              AuthService _authService = AuthService();

                              final userData = await _authService.loginUser(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim());
                              print(userData);
                              if (userData != null) {
                                if (userData['role'] == 'user') {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/navigation',
                                    (route) => false,

                                  );
                                } else if (userData['role'] == 'eventmanager' ) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/eventhome',
                                    (route) => false,
                                  );

                                  _showSuccessMessage();
                                }else if(userData['role']=='admin'){
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/admin',
                                        (route) => false,
                                  );
                                }
                              }else{
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(

                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Text("Error, please wait or contact admin ")
                                        ],
                                      ),
                                    ),
                                  );
                                });
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
                              "Sign In",
                              style: TextStyle(color: Colors.orange),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // bool ok = _loginKey.currentState!.validate();
                            // if (ok) {
                            //   print(_emailController.text);
                            //   print(_passwordController.text);
                            //  }
                          },
                          child: Container(
                            height: 55,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.g_mobiledata, color: Colors.black),
                                  SizedBox(width: 8),
                                  Text(
                                    "Log in with Google",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ?"),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterTab()));
                              },
                              child: Text(
                                "Sign Up",
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
      ),
    );
  }
}
