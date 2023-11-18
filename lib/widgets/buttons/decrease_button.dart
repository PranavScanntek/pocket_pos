import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/utils/responsive.dart';

import '../../utils/images.dart';

class DecreaseButton extends StatelessWidget {
  late Function() onTap;
  DecreaseButton({required this.onTap});

  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: size?.hp(2),
        width: size?.wp(3),
        child: SvgPicture.asset(minus,
          color: theme.indicatorColor,
        ),
      ),
    );
  }
}
