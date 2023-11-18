import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/auth/signUp_screen.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/authButton.dart';
import 'package:pocket_pos/widgets/text/textWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/curvedCliper.dart';
import '../../widgets/containers/auth_field.dart';
import '../dash/home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Screen ? size;
  bool visibility = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedEmail = prefs.getString('username');
      final String? savedPassword = prefs.getString('password');

      if (username == savedEmail && password == savedPassword) {
        prefs.setBool('isLoggedIn', true);
        Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter valid username and password'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fill all fields'),
        ),
      );
    }
  }

  void toggleVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size?.hp(99),
              color: Colors.transparent,
            ),
            Container(
              width: double.infinity,
              height: size?.hp(70),
              color: theme.scaffoldBackgroundColor, // Background color of the curved container
              child: ClipPath(
                clipper: CurvedContainerClipper(),
                child: Container(
                  width: double.infinity,
                  color: theme.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal:20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('logo',
                          style: TextStyle(
                              fontSize: 25,
                              color: theme.highlightColor
                          ),
                        ),
                        SizedBox(height: size?.hp(12),),
                        Text('Let\'s get',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900,
                            color: theme.highlightColor,
                            fontSize: MediaQuery.of(context).size.width * 0.10,
                          ),
                        ),
                        Text('Started!',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            color: theme.highlightColor,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),// Same color as the background
                ),
              ),
            ),
            Positioned(
              bottom: size?.hp(10),
              left: size?.wp(5),
              right: size?.wp(5),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor,
                      offset: Offset(0, 4),
                      blurRadius: 25
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthField(
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                          helperStyle: TextStyle(
                            color: theme.hintColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400
                          )
                        ),
                      ),
                    ),
              SizedBox(height: size?.hp(2),),
                    AuthField(
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !visibility,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      helperStyle: TextStyle(
                          color: theme.hintColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500
                      ),
                    suffixIcon: IconButton(
                        icon: Icon(!visibility?Icons.visibility_outlined:Icons.visibility,color: !visibility?theme.hintColor:theme.hintColor),
                      onPressed: toggleVisibility
                    )
                  ),
                ),
              ),
                    SizedBox(height: size?.hp(3),),
                    AuthButton(
                      width: size!.hp(78),
                      text: 'Login', action: (){
                        _login(context);
                    },
                      textColor: theme.highlightColor,boxColor: theme.primaryColor,),
                    SizedBox(height: size?.hp(1),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthPri(text: 'By continuing. you agree to (name)\'s '),
                        AuthSec(text: 'Terms of')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthSec(text: 'service '),
                        AuthPri(text: 'and '),
                        AuthSec(text: 'Privacy policy')
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    Row(
                      children: [
                        Expanded(child: Divider(
                          endIndent: 15,
                          thickness: 1,
                          color: theme.secondaryHeaderColor,
                        )
                        ),
                        Text('OR',
                          style: TextStyle(
                            color: theme.secondaryHeaderColor,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                        Expanded(child: Divider(
                          indent: 15,
                          thickness: 1,
                          color: theme.secondaryHeaderColor,
                        )
                        ),
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    AuthButton(
                        width: size!.hp(78),
                        text: 'Register new', action: (){
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>SignUpScreen()));
                    },
                        textColor: theme.primaryColor,
                        boxColor: theme.scaffoldBackgroundColor)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
