import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../model/product_model.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/bag_button.dart';
import '../../../../widgets/buttons/theme_button.dart';
import '../../../../widgets/containers/text_container.dart';
import '../../../../widgets/tabBottomNavi.dart';
import '../../../../widgets/tab_drawer.dart';
import '../home/tab_bag_screen.dart';

class TabAssignCategory extends StatefulWidget {
  const TabAssignCategory({super.key});

  @override
  State<TabAssignCategory> createState() => _TabAssignCategoryState();
}

class _TabAssignCategoryState extends State<TabAssignCategory> {

  Screen ? size;
  List<bool> checkedItems = [false, false];

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.products;
    List<Product> productList=List.from(product);
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
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextContainer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded,color: theme.hintColor,),
                        border: InputBorder.none,
                        hintText: 'Search',
                        helperStyle: TextStyle(
                            color: theme.hintColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    color: theme.focusColor),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  color: theme.scaffoldBackgroundColor,
                  child: GridView.builder(
                    shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 4,
                        childAspectRatio: .60,
                      ),
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context,int index){
                        final prdts = productList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              width: size?.wp(26),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(prdts.image,
                                    width: size?.wp(25),
                                    height: size?.hp(20),
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: Text(prdts.name,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: MediaQuery.of(context).size.width * 0.0225,
                                      ),
                                    ),
                                  ),
                                  Text('${currencyNotifier.selectedCurrency} ${prdts.amount}',
                                    style: TextStyle(
                                      color: prdts.amount>0?theme.primaryColor:theme.scaffoldBackgroundColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Transform.scale(
                                        scale:size?.wp(.2),
                                        child: Checkbox(
                                          activeColor: Colors.greenAccent,
                                          value: checkedItems[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkedItems[index] = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthButton(textSize: 0.03,text: 'Cancel', action: (){
                  // Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabAssignCategory()));
                },
                    textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(46)),
                AuthButton(textSize: 0.03,text: 'Save', action: (){
                  // Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabAddProduct()));
                },
                    textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(46))
              ],
            ),
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
