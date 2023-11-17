import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  late Widget child;
  AuthField({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: theme.shadowColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: child,
    );
  }
}
