import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/auth/signIn_screen.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/containers/auth_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/provider_helper/currency_provider.dart';
import '../../model/country_model.dart';
import '../../utils/curvedCliper.dart';
import '../../widgets/buttons/authButton.dart';
import '../../widgets/text/textWidgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Screen ? size;
  bool visibility = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController= TextEditingController();
  String selectedCountry='Select a country';
  String countryFlag= blank;

  void toggleVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }

  List<Country> countries = [
    Country(name: 'Select a country', flagImagePath: blank),
    Country(name:'India', flagImagePath: india),
    Country(name:'UAE', flagImagePath:uae),
    Country(name:'KSA', flagImagePath:ksa),
    Country(name:'Bahrain', flagImagePath:baharain),
    Country(name:'Qatar', flagImagePath:qatar),
  ];

  void _signUp(BuildContext context) async {
    final String name = nameController.text;
    final String username = usernameController.text;
    final String password = passwordController.text;
    final String email = emailController.text;
    final String country = selectedCountry;
    final String flag= countryFlag;
    if (email.isNotEmpty && name.isNotEmpty && password.isNotEmpty && country.isNotEmpty && username.isNotEmpty && countryFlag.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', name);
      prefs.setString('email', email);
      prefs.setString('username', username);
      prefs.setString('password', password);
      prefs.setString('country', country);
      prefs.setString('flag', flag);
      prefs.setBool('isLoggedIn', true);

      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>SignInScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please  fill all fields'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
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
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('logo',
                          style: TextStyle(
                              fontSize: 25,
                              color: theme.highlightColor
                          ),
                        ),
                        SizedBox(height: size?.hp(4),),
                        Text('Create',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900,
                            color: theme.highlightColor,
                            fontSize: MediaQuery.of(context).size.width * 0.10,
                          ),
                        ),
                        Text('account',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            color: theme.highlightColor,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size?.hp(2),
              left: size?.wp(5),
              right: size?.wp(5),
              child: Container(
                padding: EdgeInsets.all(15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HintText(text: 'Business name'),
                    AuthField(
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Email'),
                    AuthField(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Username'),
                    AuthField(
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Password'),
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
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Country'),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 12,right: 20),
                      decoration: BoxDecoration(
                          color: theme.shadowColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: DropdownButton(
                        iconDisabledColor: Color.fromRGBO(175, 175, 175, 1),
                        iconEnabledColor: Color.fromRGBO(175, 175, 175, 1),
                        isExpanded: true,
                        underline: SizedBox(),
                        elevation: 0,
                        value: currencyNotifier.selectedCountry,
                          items: countries.map((Country country){
                            return DropdownMenuItem<String>(
                              value: country.name,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(country.flagImagePath,
                                    height: 12,
                                  ),
                                  SizedBox(width: 10),
                                  Text(country.name,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue){
                          setState(() {
                            currencyNotifier.selectedCountry=newValue!;
                            selectedCountry = newValue;
                            countryFlag = countries
                                .firstWhere((country) => country.name == newValue)
                                .flagImagePath;
                          });
                          }
                    ),
                    ),
                    SizedBox(height: size?.hp(3),),
                    AuthButton(
                      width: size!.hp(78),
                      text: 'Register',
                      action: (){
                        _signUp(context);
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
