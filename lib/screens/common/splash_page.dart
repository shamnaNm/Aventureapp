
import 'package:aventure/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  AuthService _authService = AuthService();
  bool isLogin = false;
  var role;
  checkLogin() async {
    isLogin = await _authService.isLoggedin();
    if (isLogin == true) {
      if (role == 'user') {
        Navigator.pushNamedAndRemoveUntil(
            context, '/navigation', (route) => false);
      } else if (role == 'eventmanager') {
        Navigator.pushNamedAndRemoveUntil(context, '/eventhome', (route) => false);
      } else if (role == 'admin') {
        Navigator.pushNamedAndRemoveUntil(
            context, '/admin', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    role = await _pref.getString('role');
  }
  @override
  void initState() {
    getData();
    Future.delayed(Duration(seconds:5), () {
      checkLogin();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Image.asset('assets/img/aventures.png'),

            ],
          ),
        ),
      ),
    );
  }
}
