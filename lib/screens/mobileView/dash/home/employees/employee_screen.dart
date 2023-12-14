import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/add_button.dart';
import 'package:pocket_pos/widgets/buttons/edit_button.dart';
import 'package:pocket_pos/widgets/my_bottom.dart';
import 'package:pocket_pos/widgets/text/textWidgets.dart';
import 'package:pocket_pos/widgets/containers/text_container.dart';

import '../../../../../widgets/buttons/authButton.dart';
import '../../../../../widgets/buttons/back_button.dart';
import '../../../../../widgets/text/appBar_title.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  Screen ? size;
  bool showAdministratorEditButton = false;
  bool showManagerEditButton = false;
  bool showCashierEditButton = false;


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Employees'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal:20,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HintText(text: 'Administrator',textSize: 0.031),
                    Row(
                      children: [
                        EditButton(onTap: (){
                          setState(() {
                            showAdministratorEditButton=true;
                          });
                        }),
                        SizedBox(width: size?.wp(10),),
                        AddButton(onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: theme.scaffoldBackgroundColor,
                                title: HintText(text: 'Administrator',textSize: 0.031),
                                content: Container(
                                  height: size?.hp(25),
                                  child: Column(
                                    children: [
                                      TextContainer(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'name',
                                              helperStyle: TextStyle(
                                                  color: theme.hintColor,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                          color: theme.scaffoldBackgroundColor),
                                      SizedBox(height: size?.hp(2),),
                                      Row(
                                        children: [
                                          HintText(text: 'PIN',textSize: 0.031),
                                          Expanded(
                                            child: TextContainer(
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: '8888',
                                                    helperStyle: TextStyle(
                                                        color: theme.hintColor,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                                color: theme.focusColor
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AuthButton(
                                              textSize: 0.035,
                                              text: 'Cancel',
                                              action: () {
                                                setState(() {
                                                });
                                              },
                                              textColor: theme.primaryColor,
                                              boxColor: theme.scaffoldBackgroundColor,
                                              width: size!.wp(30),
                                            ),
                                            SizedBox(width: size?.wp(4),),
                                            AuthButton(
                                              textSize: 0.035,
                                              text: 'Save',
                                              action: () {
                                                setState(() {
                                                });
                                              },
                                              textColor: theme.highlightColor,
                                              boxColor: theme.primaryColor,
                                              width: size!.wp(30),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        })
                      ],
                    )
                  ],
                ),
                SizedBox(height: size?.hp(2),),
                TextContainer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'name',
                        helperStyle: TextStyle(
                            color: theme.hintColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                ),
                    color: theme.scaffoldBackgroundColor),
                SizedBox(height: size?.hp(2),),
                Row(
                  children: [
                    HintText(text: 'PIN',textSize: 0.031),
                    Expanded(
                      child: TextContainer(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '8888',
                              helperStyle: TextStyle(
                                  color: theme.hintColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          color: theme.focusColor
                      ),
                    ),
                  ],
                ),
                if(showAdministratorEditButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AuthButton(
                          textSize: 0.035,
                          text: 'Cancel',
                          action: () {
                            setState(() {
                              showAdministratorEditButton=false;
                            });
                          },
                          textColor: theme.primaryColor,
                          boxColor: theme.scaffoldBackgroundColor,
                          width: size!.wp(42),
                        ),
                        SizedBox(width: size?.wp(5),),
                        AuthButton(
                          textSize: 0.035,
                          text: 'Save',
                          action: () {
                            setState(() {
                              showAdministratorEditButton=false;
                            });
                          },
                          textColor: theme.highlightColor,
                          boxColor: theme.primaryColor,
                          width: size!.wp(42),
                        ),
                      ],
                    ),
                  ),
              ],
            )
            ),
            Divider(
              color: theme.primaryColor,
              thickness: 1,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HintText(text: 'Manager',textSize: 0.031),
                        Row(
                          children: [
                            EditButton(onTap: (){
                              setState(() {
                                showManagerEditButton=true;
                              });
                            }),
                            SizedBox(width: size?.wp(10),),
                            AddButton(onTap: (){})
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    TextContainer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'name',
                            helperStyle: TextStyle(
                                color: theme.hintColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        color: theme.scaffoldBackgroundColor),
                    SizedBox(height: size?.hp(2),),
                    Row(
                      children: [
                        HintText(text: 'PIN',textSize: 0.031),
                        Expanded(
                          child: TextContainer(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '8888',
                                  helperStyle: TextStyle(
                                      color: theme.hintColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              color: theme.focusColor
                          ),
                        ),
                      ],
                    ),
                    if(showManagerEditButton)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AuthButton(
                              textSize: 0.035,
                              text: 'Cancel',
                              action: () {
                                setState(() {
                                  showManagerEditButton=false;
                                });
                              },
                              textColor: theme.primaryColor,
                              boxColor: theme.scaffoldBackgroundColor,
                              width: size!.wp(42),
                            ),
                            AuthButton(
                              textSize: 0.035,
                              text: 'Save',
                              action: () {
                                setState(() {
                                  showManagerEditButton=false;
                                });
                              },
                              textColor: theme.highlightColor,
                              boxColor: theme.primaryColor,
                              width: size!.wp(42),
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
            Divider(
              color: theme.primaryColor,
              thickness: 1,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HintText(text: 'Cashier',textSize: 0.031),
                        Row(
                          children: [
                            EditButton(onTap: (){
                              setState(() {
                                showCashierEditButton=true;
                              });
                            }),
                            SizedBox(width: size?.wp(10),),
                            AddButton(onTap: (){})
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    TextContainer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'name',
                            helperStyle: TextStyle(
                                color: theme.hintColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        color: theme.scaffoldBackgroundColor),
                    SizedBox(height: size?.hp(2),),
                    Row(
                      children: [
                        HintText(text: 'PIN',textSize: 0.031),
                        Expanded(
                          child: TextContainer(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '8888',
                                  helperStyle: TextStyle(
                                      color: theme.hintColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              color: theme.focusColor
                          ),
                        ),
                      ],
                    ),
                    if(showCashierEditButton)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AuthButton(
                              textSize: 0.035,
                              text: 'Cancel',
                              action: () {
                                setState(() {
                                  showCashierEditButton=false;
                                });
                              },
                              textColor: theme.primaryColor,
                              boxColor: theme.scaffoldBackgroundColor,
                              width: size!.wp(42),
                            ),
                            AuthButton(
                              textSize: 0.035,
                              text: 'Save',
                              action: () {
                                setState(() {
                                  showCashierEditButton=false;
                                });
                              },
                              textColor: theme.highlightColor,
                              boxColor: theme.primaryColor,
                              width: size!.wp(42),
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
          ],
        ),
      ),
        bottomNavigationBar:MyBottomBar(
          hasFocus: false,
          hasFocus2: false,
          hasFocus3: false,
          hasFocus4: false,
        )    );
  }
}
