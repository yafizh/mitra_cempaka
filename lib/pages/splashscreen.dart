import 'package:flutter/material.dart';
import 'package:mitra_cempaka/pages/home_page.dart';
import 'package:mitra_cempaka/pages/login_page.dart';
import 'package:mitra_cempaka/services/storage/auth_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  _checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    final page = (await AuthPreferences.isLoggedIn())
        ? HomePage()
        : LoginPage();
        
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('MITRA CEMPAKA')));
  }
}
