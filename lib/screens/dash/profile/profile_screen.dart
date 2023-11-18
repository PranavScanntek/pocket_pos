import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_pos/screens/dash/profile/profile_settings_screen.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/authButton.dart';
import 'package:pocket_pos/widgets/buttons/back_button.dart';
import 'package:pocket_pos/widgets/containers/text_container.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/provider_helper/currency_provider.dart';
import '../../../model/country_model.dart';
import '../../../utils/images.dart';
import '../../../widgets/text/appBar_title.dart';
import '../../../widgets/my_bottom.dart';
import '../../../widgets/text/textWidgets.dart';
class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  Screen ? size;
  bool visibility = false;
  String? selectedCountry;
  late SharedPreferences data;

  List<Country> countries = [
    Country(name:'India', flagImagePath: india),
    Country(name:'UAE', flagImagePath:uae),
    Country(name:'KSA', flagImagePath:ksa),
    Country(name:'Bahrain', flagImagePath:baharain),
    Country(name:'Qatar', flagImagePath:qatar)
  ];

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
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Profile'),
      ),
      bottomNavigationBar: MyBottomBar(
        hasFocus: false,homeSelect: false,
        hasFocus2: false,reportSelect: false,
        hasFocus3: false,scannerSelect: false,
        hasFocus4: true,profile: true,
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          final SharedPreferences=snapshot.data!;
          final image = SharedPreferences.getString('image');
          final name= SharedPreferences.getString('name');
          final email = SharedPreferences.getString('email');
          final country = SharedPreferences.getString('country');
          final flag = SharedPreferences.getString('flag');
            return  Padding(
              padding: const EdgeInsets.symmetric(vertical:10,horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: image!=null?
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(image)),
                              )
                          :CircleAvatar(
                            radius: 60,
                            backgroundColor: theme.hintColor,
                            child: Icon(Icons.person),
                          )
                        ),
                        SizedBox(height: size?.hp(1),),
                        HintText(text: 'Business name'),
                        TextContainer(
                            color: theme.scaffoldBackgroundColor,
                            child: name!=null?
                            Text('$name')
                                :Text('')
                        ),
                        SizedBox(height: size?.hp(1),),
                        HintText(text: 'Email'),
                        TextContainer(
                            color: theme.scaffoldBackgroundColor,
                            child: email!=null?
                            Text('$email')
                                :Text('')
                        ),
                        SizedBox(height: size?.hp(1),),
                        HintText(text: 'Country'),
                        TextContainer(
                            color: theme.scaffoldBackgroundColor,
                            child: Row(
                              children: [
                                Image.asset('$flag',
                                  height: 12,
                                ),
                                SizedBox(width: 10),
                                country!=null?
                                Text('$country',
                                ):Text('')
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size?.wp(43),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: theme.primaryColor),
                            color: theme.scaffoldBackgroundColor
                        ),
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>ProfileSettingsScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.settings_outlined,color: theme.primaryColor,),
                                SizedBox(width: size?.wp(2),),
                                Text('Settings',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.width * 0.035,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                      Container(
                        width: size?.wp(43),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: theme.primaryColor),
                            color: theme.scaffoldBackgroundColor
                        ),
                        child: TextButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: theme.focusColor,
                                  contentPadding: EdgeInsets.all(10),
                                  content: Container(
                                    height: size?.hp(15),
                                    child: Column(
                                      children: [
                                        Text('Are you sure?\nyou want to close your day?',style: TextStyle(color: theme.indicatorColor),),
                                        Padding(
                                          padding: const EdgeInsets.only(top:10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AuthButton(text: 'Cancel', action: (){
                                                Navigator.pop(context);
                                              }, textColor: theme.primaryColor, boxColor: theme.focusColor, width: size!.wp(26)),
                                              SizedBox(width: size?.wp(4),),
                                              AuthButton(text: 'Done', action: (){
                                                SystemNavigator.pop();
                                              }, textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(26))

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Close day',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.width * 0.035,
                                  ),
                                ),
                                SizedBox(width: size?.wp(2),),
                                Icon(Icons.logout_outlined,color: theme.primaryColor,)
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

      )
    );
  }
}
