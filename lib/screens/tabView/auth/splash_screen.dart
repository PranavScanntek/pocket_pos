import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/tabView/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mobileView/auth/pin_screen.dart';

class SplashScreen extends StatefulWidget {



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = _prefs?.getBool('isLoggedIn') ?? false;

    Navigator.pushReplacement(context,
      isLoggedIn
          ? MaterialPageRoute(builder: (context) => PinScreen())
          : MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Center(
        child: Text('POCKET POS',
          style: TextStyle(
              fontSize: 25,
              color: theme.highlightColor
          ),
        ),
      ),
    );
  }
}
