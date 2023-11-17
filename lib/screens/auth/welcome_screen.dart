import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/auth/pin_screen.dart';
import 'package:pocket_pos/screens/auth/signIn_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
          : MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 15),
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
