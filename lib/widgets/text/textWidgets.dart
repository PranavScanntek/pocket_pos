import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';

class AuthPri extends StatelessWidget {
  late String text;
  late double textSize;
  AuthPri({required this.text,required this.textSize});

  Screen ? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Text(text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: theme.secondaryHeaderColor,
        fontSize: MediaQuery.of(context).size.width * textSize,
      ),
    );
  }
}

class AuthSec extends StatelessWidget {
  late String text;
  late double textSize;
  AuthSec({required this.text,required this.textSize});
  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return  Text(text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          color: theme.primaryColor,
        fontSize: MediaQuery.of(context).size.width * textSize,
      ),
    );
  }
}

class HintText extends StatelessWidget {
  late String text;
  late double textSize;
  HintText({required this.text,required this.textSize});
  Screen ? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10,vertical: 2),
      child: Text(text,
        style: TextStyle(
          color: theme.indicatorColor,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: MediaQuery.of(context).size.width * textSize,
        ),
      ),
    );
  }
}


