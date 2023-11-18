
import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class BillingTotal extends StatelessWidget {
  Screen ? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: size?.wp(89),
      height: size?.hp(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.focusColor,
        border: Border.all(color: theme.primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total',
                style: TextStyle(
                  color: theme.indicatorColor,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),

              Text('Inclusive tax',
                style: TextStyle(
                  color: theme.indicatorColor,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                ),
              ),
            ],
          ),
          Text('\u{20B9} 1000',
            style: TextStyle(
              color: theme.indicatorColor,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          )
        ],
      ),
    );
  }
}
