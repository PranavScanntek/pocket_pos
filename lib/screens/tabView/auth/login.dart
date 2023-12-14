import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/tabView/auth/register.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_home.dart';
import 'package:pocket_pos/utils/tabCurvedClipper.dart';

import '../../../utils/curvedCliper.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/buttons/authButton.dart';
import '../../../widgets/containers/auth_field.dart';
import '../../../widgets/text/textWidgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Screen ? size;
  bool visibility = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              width: size?.wp(100),
              height: size?.hp(100),
              color: Colors.transparent,
            ),
            Container(
              width:size?.wp(82.5),
              height: size?.hp(100),
              color: theme.scaffoldBackgroundColor, // Background color of the curved container
              child: ClipPath(
                clipper: TabCurvedClipper(),
                child: Container(
                  height: double.infinity,
                  width: size?.wp(100),
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
                        SizedBox(height: size?.hp(20),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Let\'s get',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900,
                                color: theme.highlightColor,
                                fontSize: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                            Text('Started!',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                color: theme.highlightColor,
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),// Same color as the background
                ),
              ),
            ),
            Positioned(
              bottom: size?.hp(18),
              right: size?.wp(4),
              top: size?.hp(18),
              child: Container(
                width: size?.wp(50),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AuthField(
                      width: double.infinity,
                      child: TextFormField(
                        controller: usernameController,
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                        ),
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
                      width: double.infinity,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !visibility,
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                        ),
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
                      height: size?.hp(7),
                      textSize: 0.0225,
                      width: double.infinity,
                      text: 'Login', action: (){
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabHomeScreen()));
                      // _login(context);
                    },
                      textColor: theme.highlightColor,boxColor: theme.primaryColor,),
                    SizedBox(height: size?.hp(1),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthPri(text: 'By continuing. you agree to (name)\'s ',textSize: 0.0175,),
                        AuthSec(text: 'Terms of',textSize: 0.02)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthSec(text: 'service ',textSize: 0.02),
                        AuthPri(text: 'and ',textSize: 0.0175),
                        AuthSec(text: 'Privacy policy',textSize: 0.02)
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    Row(
                      children: [
                        Expanded(child: Divider(
                          endIndent: 15,
                          thickness: 1,
                          color: theme.hintColor,
                        )
                        ),
                        Text('or',
                          style: TextStyle(
                            color: theme.hintColor,
                            fontSize: MediaQuery.of(context).size.width * 0.025,
                          ),
                        ),
                        Expanded(child: Divider(
                          indent: 15,
                          thickness: 1,
                          color: theme.hintColor,
                        )
                        ),
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    AuthButton(
                        height: size?.hp(7),
                        textSize: 0.0225,
                        width: double.infinity,
                        text: 'Register new', action: (){
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>RegisterScreen()));
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
