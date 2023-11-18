import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';

class AddButton extends StatelessWidget {

  late Function() onTap;
  AddButton({required this.onTap});

  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(add,
        height: size?.hp(2),
        width: size?.wp(4),
        color: theme.indicatorColor,
      ),
    );
  }
}
