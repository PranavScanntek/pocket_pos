import 'package:flutter/material.dart';

class Inter500 extends StatelessWidget {
  late String text;
  Inter500({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(text,
        style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: theme.indicatorColor
                    ),
    );
  }
}
