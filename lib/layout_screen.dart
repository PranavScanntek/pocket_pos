import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/mobileView/auth/welcome_screen.dart';
import 'package:pocket_pos/screens/tabView/auth/splash_screen.dart';

class LayOutScreen extends StatelessWidget {
  const LayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return SplashScreen();
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
