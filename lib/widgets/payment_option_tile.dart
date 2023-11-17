import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';

class PaymentOption extends StatelessWidget {
  late String text;
  late String image;
  late Color? color;
  late Function() onPressed;
  PaymentOption({required this.text,required this.image,this.color,required this.onPressed});

  Screen? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border.all(color: theme.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Container(
              width: size?.wp(8),
                child: SvgPicture.asset(image,height: size?.hp(3.5),width: size?.wp(7.5),color: color,)),
            SizedBox(width: size?.wp(4),),
            Text(text,
              style: TextStyle(
                color: theme.primaryColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
      ),
    );
  }
}
