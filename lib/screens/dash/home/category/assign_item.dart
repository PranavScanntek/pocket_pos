import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/add_button.dart';
import 'package:provider/provider.dart';

import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../utils/images.dart';
import '../../../../widgets/text/appBar_title.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/my_bottom.dart';
import '../product/add_products_screen.dart';

class AssignItemToCategory extends StatefulWidget {
  const AssignItemToCategory({super.key});

  @override
  State<AssignItemToCategory> createState() => _AssignItemToCategoryState();
}

class _AssignItemToCategoryState extends State<AssignItemToCategory> {

  List<String> foodPic=[biriyani,fish];
  List<String> foodName=['Chicken\nBiriyani','Fish'];
  List<String> foodPrice=['130',''];
  List<bool> checkedItems = [false, false];

  Screen ? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Assign items'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: AddButton(onTap: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>AddProductsScreen()));
            })
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                color: theme.focusColor,
                padding: EdgeInsets.all(5),
                child: ListTile(
                  tileColor: theme.focusColor,
                  title: Text(foodName[index],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.035,
                    ),
                  ),
                  subtitle: Text('${currencyNotifier.selectedCurrency} ${foodPrice[index]}',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.045,
                    ),
                  ),
                  leading: Image.asset(foodPic[index],
                    width: size?.wp(20),
                    height: size?.hp(8),
                    fit: BoxFit.fill,
                  ),
                  trailing: Checkbox(
                    activeColor: Colors.greenAccent,
                    value: checkedItems[index],
                    onChanged: (bool? value) {
                      setState(() {
                        checkedItems[index] = value!;
                      });
                    },
                  ),
                ),
              ),
            );
          }
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: size?.hp(15),
        color: theme.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AuthButton(text: 'Cancel', action: (){
              Navigator.pop(context);
            },
                textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(43)),
            AuthButton(text: 'Save', action: (){
              Navigator.pop(context);
            },
                textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(43))
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(hasFocus: false, hasFocus2: false, hasFocus3: false, hasFocus4: false, reportSelect: false, scannerSelect: false, homeSelect: false, profile: false),
    );
  }
}
