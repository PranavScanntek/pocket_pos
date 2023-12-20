import 'package:flutter/material.dart';

class TabTextButton extends StatelessWidget {
  late Color color;
  late String text;
  late Function() onPressed;
  TabTextButton({required this.color,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
          onTap: onPressed,
          child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
          ),
      ),
    );
  }
}
