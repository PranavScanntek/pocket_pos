import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class TabPaymentButton extends StatelessWidget {
  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: size?.wp(15),
        padding: EdgeInsets.symmetric(vertical:10),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Text('Paid',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.highlightColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width * 0.025,
          ),
        ),
      ),
    );
  }
}
