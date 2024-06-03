import 'package:aventure/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
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


  String email = "";
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text("Forgot pasword"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _loginKey,
            child: Column(
              children: <Widget>[
                Text(
                  "We will mail you a link....please click on that link to reset your password.",
                  style: TextStyle(fontSize: 18),
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
                InkWell(
                  onTap: () async {
                    if (_loginKey.currentState!.validate()) {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email).then((value) => print("check your emails"));
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
                      "Send Email",
                      style: TextStyle(color: Colors.orange),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
