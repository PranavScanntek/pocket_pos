import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/screens/dash/home/category/category_items.dart';
import 'package:pocket_pos/widgets/buttons/add_button.dart';
import 'package:pocket_pos/widgets/my_bottom.dart';
import 'package:pocket_pos/widgets/containers/text_container.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/text/appBar_title.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/back_button.dart';
import '../product/add_products_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Screen ? size;
  bool hasFocus= false;
  bool unFocus= true;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Add category'),
        actions: [
          if(unFocus)
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AddButton(onTap: (){
              setState(() {
                  hasFocus=true;
                  unFocus= false;
              });
            })
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(hasFocus)
              Center(
                child: TextContainer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type here',
                        helperStyle: TextStyle(
                            color: theme.hintColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    color: theme.focusColor),
              ),
            GestureDetector(
              onTap: (){},
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text('Veg',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: theme.indicatorColor,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            SizedBox(height: size?.hp(3),),
            GestureDetector(
              onTap: (){
                Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>CategoryItems()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: Text('Non veg',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: theme.indicatorColor,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: size?.hp(20),
        color: theme.scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasFocus)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AuthButton(
                      text: 'Cancel',
                      action: () {
                        setState(() {
                          hasFocus=false;
                          unFocus= true;
                        });
                      },
                      textColor: theme.primaryColor,
                      boxColor: theme.scaffoldBackgroundColor,
                      width: size!.wp(43),
                    ),
                    SizedBox(width: size?.wp(4),),
                    AuthButton(
                      text: 'Save',
                      action: () {
                        setState(() {
                          hasFocus=false;
                          unFocus= true;
                        });
                      },
                      textColor: theme.highlightColor,
                      boxColor: theme.primaryColor,
                      width: size!.wp(43),
                    ),
                  ],
                ),
              ),
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
