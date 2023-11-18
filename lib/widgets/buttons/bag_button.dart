import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';

import '../../screens/dash/home/bag_screen.dart';

class BagButton extends StatelessWidget {
  Screen ? size;
  Function()? action;
  BagButton({this.action});

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: action,
      child: SvgPicture.asset(bag,
        height: size?.hp(3),
        width: size?.wp(4),
        color: theme.indicatorColor,
      ),
    );
  }
}
