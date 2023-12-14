import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';

class AuthButton extends StatelessWidget {
 late String text;
 late double textSize;
 late Function() action;
 late Color textColor;
 late Color boxColor;
 late double? width;
 late double? height;

 AuthButton({required this.text,required this.action,required this.textColor,required this.boxColor,this.width,this.height,required this.textSize});
 Screen ? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.primaryColor),
        color: boxColor
      ),
      child: TextButton(
          onPressed: action,
          child: Text(text,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width * textSize,
            ),
          ),
      ),
    );
  }
}
