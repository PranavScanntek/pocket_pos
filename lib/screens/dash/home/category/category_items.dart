import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/dash/home/category/assign_item.dart';
import 'package:pocket_pos/screens/dash/home/product/add_products_screen.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../utils/images.dart';
import '../../../../widgets/text/appBar_title.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/my_bottom.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({super.key});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  Screen ? size;

  List<String> foodPic=[biriyani,biriyani];
  List<String> foodName=['Chicken\nBiriyani','Chicken\nBiriyani'];
  List<String> foodPrice=['130','130'];

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
        title: AppBarTitle(text: 'Non veg'),
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
            AuthButton(text: 'Assign item', action: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>AssignItemToCategory()));
            },
                textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(43)),
            AuthButton(text: 'Add item', action: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>AddProductsScreen()));
            },
                textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(43))
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(hasFocus: false, hasFocus2: false, hasFocus3: false, hasFocus4: false, reportSelect: false, scannerSelect: false, homeSelect: false, profile: false),
    );
  }
}
