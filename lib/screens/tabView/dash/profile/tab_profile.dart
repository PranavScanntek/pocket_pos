import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_pos/screens/tabView/dash/profile/tab_profile_settings.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/bag_button.dart';
import '../../../../widgets/buttons/theme_button.dart';
import '../../../../widgets/containers/text_container.dart';
import '../../../../widgets/tabBottomNavi.dart';
import '../../../../widgets/tab_drawer.dart';
import '../../../../widgets/text/textWidgets.dart';
import '../home/tab_bag_screen.dart';

class TabProfile extends StatelessWidget {
  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TabDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              child: Icon(
                Icons.menu,
                color: theme.indicatorColor, // Change the icon color here
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('Logo',
          style: TextStyle(
              color: theme.indicatorColor
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: BagButton(
                  action: () {
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabBagScreen()));
                  }
              )
          ),
          ThemedButton()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Center(
    child:CircleAvatar(
    radius: 100,
    backgroundColor: theme.hintColor,
    child: Icon(Icons.person),
    )
    ),
    SizedBox(height: size?.hp(1),),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HintText(text: 'Business name',textSize: 0.02),
            TextContainer(
              width: size?.wp(45),
                color: theme.scaffoldBackgroundColor,
                child:Text('')
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HintText(text: 'Email',textSize: 0.02),
            TextContainer(
                width: size?.wp(45),
                color: theme.scaffoldBackgroundColor,
                child: Text('')
            ),
          ],
        )
      ],
    ),
    SizedBox(height: size?.hp(1),),
    HintText(text: 'Country',textSize: 0.02),
    TextContainer(
        width: size?.wp(45),
    color: theme.scaffoldBackgroundColor,
    child: Row(
    children: [
    SizedBox(width: 10),
    Text(''),
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
            width: size?.wp(45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.primaryColor),
                color: theme.scaffoldBackgroundColor
            ),
            child: TextButton(
              onPressed: (){
                Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabProfileSettings()));
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings_outlined,color: theme.primaryColor,size: size?.hp(5),),
                    SizedBox(width: size?.wp(2),),
                    Text('Settings',
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                  ]
              ),
            ),
          ),
          Container(
            width: size?.wp(45),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
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
                                  },
                                      textSize: 0.03,textColor: theme.primaryColor, boxColor: theme.focusColor, width: size!.wp(26)),
                                  SizedBox(width: size?.wp(4),),
                                  AuthButton(text: 'Done', action: (){
                                    SystemNavigator.pop();
                                  },
                                      textSize: 0.03,textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(26))

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
                        fontSize: MediaQuery.of(context).size.width * 0.03,
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
      ]
    )
    ),
      bottomNavigationBar: TabBottomNavi(
      hasFocus: false,
      hasFocus2: false,
      hasFocus3: false,
    ),
    );
  }
}
