import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';

class TimeContainer extends StatelessWidget {


  late Color textColor;
  late Color boxColor;
  late String text;

  TimeContainer({required this.text,required this.boxColor,required this.textColor});

  Screen ? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: boxColor
      ),
      child: Text(text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          color: textColor,

          fontSize: MediaQuery.of(context).size.width * 0.035,
        ),
      ),
    );
  }
}
