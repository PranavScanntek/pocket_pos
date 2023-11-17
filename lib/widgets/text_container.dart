import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';

class TextContainer extends StatelessWidget {
  Screen ? size;
  late Widget child;
  late Color color;
  late double? width;
  TextContainer({required this.child,required this.color,this.width});

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      height: size?.hp(6.5),
      width: width,
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: theme.shadowColor,
          borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color)
      ),
      child: child
    );
  }
}
