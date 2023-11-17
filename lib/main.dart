import 'package:flutter/material.dart';
import 'package:pocket_pos/helper/provider_helper/currency_provider.dart';
import 'package:pocket_pos/helper/provider_helper/product_provider.dart';
import 'package:pocket_pos/screens/auth/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'helper/provider_helper/theme_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider()),
      ChangeNotifierProvider(create: (context) => CountryNotifier()),
    ],
      child: MyApp()));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          theme: Provider.of<ThemeProvider>(context).currentTheme,
            home: WelcomeScreen()
        );
      },
    );
  }
}
