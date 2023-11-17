import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/appBar_title.dart';
import 'package:pocket_pos/widgets/back_button.dart';

import '../../../../utils/images.dart';
import '../../../../widgets/authButton.dart';
import '../../../../widgets/my_bottom.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  Screen? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: PopButton(),
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: AppBarTitle(text: 'Card',),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select card',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: size?.hp(3),),
            Center(
              child: Container(
                width: size?.wp(70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap:(){},child: SvgPicture.asset(visa)),
                    GestureDetector(onTap:(){},child: SvgPicture.asset(masterCard)),
                    GestureDetector(onTap:(){},child: SvgPicture.asset(rupay)),
                    GestureDetector(onTap:(){},child: SvgPicture.asset(americanExp)),
                  ],
                ),
              ),
            ),
            SizedBox(height: size?.hp(3),),
            Center(
              child: Text("Press confirm after the payment\ncompleted in the swiping\nmachine",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: theme.scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AuthButton(text: 'Cancel', action: (){
                Navigator.pop(context);
              },
                  textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(43)),
              AuthButton(text: 'Confirm', action: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Icon(Icons.check,color: theme.highlightColor,),
                      ),
                      content: Container(
                        height: size?.hp(8),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Successfully',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: theme.highlightColor
                                  ),
                                ),
                                Text(' completed',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: theme.highlightColor
                                  ),
                                )
                              ],
                            ),
                            Text('new sale',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: theme.highlightColor
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
                  textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(43))
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomBar(
        hasFocus: false,homeSelect: false,
        hasFocus2: false,reportSelect: false,
        hasFocus3: false,scannerSelect: false,
        hasFocus4: false,profile: false,
      ),
    );
  }
}
