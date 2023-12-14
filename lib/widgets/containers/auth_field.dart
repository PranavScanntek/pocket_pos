import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  late Widget child;
  late double? width;
  late double? height;
  AuthField({required this.child,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: theme.shadowColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: child,
    );
  }
}
