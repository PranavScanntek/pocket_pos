import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/provider_helper/theme_provider.dart';

class ThemedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        onPressed: () {
          themeProvider.toggleTheme();
        },
        icon: Icon(themeProvider.currentButtonIcon,color: theme.indicatorColor,),
      ),
    );
  }
}
