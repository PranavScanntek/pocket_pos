import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_bag_screen.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../widgets/buttons/add_button.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/bag_button.dart';
import '../../../../widgets/buttons/edit_button.dart';
import '../../../../widgets/buttons/theme_button.dart';
import '../../../../widgets/containers/text_container.dart';
import '../../../../widgets/tabBottomNavi.dart';
import '../../../../widgets/tab_drawer.dart';
import '../../../../widgets/text/textWidgets.dart';

class TabEmployee extends StatefulWidget {
  const TabEmployee({super.key});

  @override
  State<TabEmployee> createState() => _TabEmployeeState();
}

class _TabEmployeeState extends State<TabEmployee> {
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
                        HintText(text: 'Administrator',textSize: 0.02),
                        Row(
                          children: [
                            if(showAdministratorEditButton==false)
                            EditButton(onTap: (){
                              setState(() {
                                showAdministratorEditButton=true;
                              });
                            }),
                            SizedBox(width: size?.wp(5),),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: AddButton(onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      backgroundColor: theme.scaffoldBackgroundColor,
                                      title: HintText(text: 'Administrator',textSize: 0.02),
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
                                                HintText(text: 'PIN',textSize: 0.02),
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
                                                    textSize: 0.03,
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
                                                    textSize: 0.03,
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
                              }),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    Row(
                      children: [
                        Expanded(
                          child: TextContainer(
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
                        ),
                        HintText(text: 'PIN',textSize: 0.02),
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
                              textSize: 0.03,
                              text: 'Cancel',
                              action: () {
                                setState(() {
                                  showAdministratorEditButton=false;
                                });
                              },
                              textColor: theme.primaryColor,
                              boxColor: theme.scaffoldBackgroundColor,
                              width: size!.wp(44),
                            ),
                            SizedBox(width: size?.wp(5),),
                            AuthButton(
                              textSize: 0.03,
                              text: 'Save',
                              action: () {
                                setState(() {
                                  showAdministratorEditButton=false;
                                });
                              },
                              textColor: theme.highlightColor,
                              boxColor: theme.primaryColor,
                              width: size!.wp(44),
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
                        HintText(text: 'Manager',textSize: 0.02),
                        Row(
                          children: [
                            if(showManagerEditButton==false)
                            EditButton(onTap: (){
                              setState(() {
                                showManagerEditButton=true;
                              });
                            }),
                            SizedBox(width: size?.wp(5),),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: AddButton(onTap: (){}),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    Row(
                      children: [
                        Expanded(
                          child: TextContainer(
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
                        ),
                        HintText(text: 'PIN',textSize: 0.02),
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
                              textSize: 0.03,
                              text: 'Cancel',
                              action: () {
                                setState(() {
                                  showManagerEditButton=false;
                                });
                              },
                              textColor: theme.primaryColor,
                              boxColor: theme.scaffoldBackgroundColor,
                              width: size!.wp(44),
                            ),
                            AuthButton(
                              textSize: 0.03,
                              text: 'Save',
                              action: () {
                                setState(() {
                                  showManagerEditButton=false;
                                });
                              },
                              textColor: theme.highlightColor,
                              boxColor: theme.primaryColor,
                              width: size!.wp(44),
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
                        HintText(text: 'Cashier',textSize: 0.02),
                        Row(
                          children: [
                            if(showCashierEditButton==false)
                            EditButton(onTap: (){
                              setState(() {
                                showCashierEditButton=true;
                              });
                            }),
                            SizedBox(width: size?.wp(5),),
                            AddButton(onTap: (){})
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: size?.hp(2),),
                    Row(
                      children: [
                        Expanded(
                          child: TextContainer(
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
                        ),
                        HintText(text: 'PIN',textSize: 0.02),
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
                              textSize: 0.03,
                              text: 'Cancel',
                              action: () {
                                setState(() {
                                  showCashierEditButton=false;
                                });
                              },
                              textColor: theme.primaryColor,
                              boxColor: theme.scaffoldBackgroundColor,
                              width: size!.wp(44),
                            ),
                            AuthButton(
                              textSize: 0.03,
                              text: 'Save',
                              action: () {
                                setState(() {
                                  showCashierEditButton=false;
                                });
                              },
                              textColor: theme.highlightColor,
                              boxColor: theme.primaryColor,
                              width: size!.wp(44),
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: TabBottomNavi(
        hasFocus: false,
        hasFocus2: false,
        hasFocus3: false,
      ),
    );
  }
}
