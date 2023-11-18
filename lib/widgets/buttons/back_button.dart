import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';

class PopButton extends StatelessWidget {

  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(back,
          height: size?.hp(2),
          width: size?.wp(4),
          color: theme.indicatorColor,
        ),
      ),
    );
  }
}
