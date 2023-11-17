import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  late String text;
  AppBarTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(text,
      style: TextStyle(
        color: theme.indicatorColor,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: MediaQuery.of(context).size.width * 0.035,
      ),
    );
  }
}
