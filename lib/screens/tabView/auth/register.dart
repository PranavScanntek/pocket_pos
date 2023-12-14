import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/tabView/auth/login.dart';
import 'package:pocket_pos/utils/tabCurvedClipper.dart';
import 'package:provider/provider.dart';

import '../../../helper/provider_helper/currency_provider.dart';
import '../../../model/country_model.dart';
import '../../../utils/images.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/buttons/authButton.dart';
import '../../../widgets/containers/auth_field.dart';
import '../../../widgets/text/textWidgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Screen ? size;
  bool visibility = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController= TextEditingController();
  final TextEditingController textEditingController = TextEditingController();

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

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
              width: size?.wp(100),
              height: size?.hp(100),
              color: Colors.transparent,
            ),
            Container(
              width:size?.wp(82.5),
              height: size?.hp(100),
              child: ClipPath(
                clipper: TabCurvedClipper(),
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
                        SizedBox(height: size?.hp(20),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Create',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900,
                                color: theme.highlightColor,
                                fontSize: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                            Text('account',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: theme.highlightColor,
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size?.hp(3.4),
              right: size?.wp(4),
              top: size?.hp(3.4),
              child: Container(
                width: size?.wp(50),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HintText(text: 'Business name',textSize: 0.0175),
                    AuthField(
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                      ),
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                        ),
                    ),
                    ),
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Email',textSize: 0.0175),
                    AuthField(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                        ),
                      ),
                    ),
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Username',textSize: 0.0175),
                    AuthField(
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                        ),
                      ),
                    ),
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Password',textSize: 0.0175),
                    AuthField(
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
                    SizedBox(height: size?.hp(1),),
                    HintText(text: 'Country',textSize: 0.0175),
                    Container(
                      height: size?.hp(7),
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 12,right: 20),
                      decoration: BoxDecoration(
                          color: theme.shadowColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: DropdownButton2<String>(
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                        ),
                        iconStyleData: IconStyleData(
                          iconDisabledColor: Color.fromRGBO(175, 175, 175, 1),
                          iconEnabledColor: Color.fromRGBO(175, 175, 175, 1),
                        ),
                        isExpanded: true,
                        underline: SizedBox(),
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
                                  style: TextStyle(
                                    color: theme.indicatorColor,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.of(context).size.width * 0.025,
                                  ),
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
                        },
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: AuthField(
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                style: TextStyle(
                                  color: theme.indicatorColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.width * 0.025,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value.toString().contains(searchValue);
                          },
                        ),
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: size?.hp(3),),
                    AuthButton(
                      height: size?.hp(7),
                      width: double.infinity,
                      textSize: 0.0225,
                      text: 'Register',
                      action: (){
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>LoginScreen()));
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
