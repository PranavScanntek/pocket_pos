import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';

class WhiteContainer extends StatelessWidget {
  late Widget child;
  WhiteContainer({required this.child});
  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: size?.hp(7),
      decoration: BoxDecoration(
        color: theme.focusColor,
      ),
      child: child,
    );
  }
}
