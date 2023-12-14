import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/tabView/dash/category/TabAssignCategory.dart';
import 'package:pocket_pos/screens/tabView/dash/home/products/tab_add_product.dart';
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
import '../../../../widgets/tabWidget/tabCategoryContainer.dart';
import '../../../../widgets/tab_drawer.dart';
import '../home/tab_bag_screen.dart';

class TabCategory extends StatefulWidget {
  const TabCategory({super.key});

  @override
  State<TabCategory> createState() => _TabCategoryState();
}

class _TabCategoryState extends State<TabCategory> {
  Screen ? size;
  bool hasFocus= false;
  bool unFocus= true;
  bool _hasText=true;
  bool _hasText2=false;
  bool _hasfocus=true;
  bool _hasfocus2=false;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.products;
    List<Product> productList=List.from(product);
    int totalProductCount = product.fold(
        0, (previousValue, product) => previousValue + product.count);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(unFocus)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: (){
                          setState(() {
                            _hasfocus=!_hasfocus;
                            _hasText= !_hasText;
                            _hasfocus2=false;
                            _hasText2=false;
                          });
                        },
                        child: TabCategoryContainer(
                          text: 'Non veg',
                          boxColor: _hasfocus?theme.primaryColor:theme.scaffoldBackgroundColor,
                          textColor: _hasText?theme.highlightColor:theme.primaryColor,
                        )
                    ),
                    SizedBox(width: size?.wp(2),),
                    InkWell(
                        onTap: (){
                          setState(() {
                            _hasfocus2=!_hasfocus2;
                            _hasText2= !_hasText2;
                            _hasfocus=false;
                            _hasText=false;
                          });
                        },
                        child: TabCategoryContainer(
                          text: 'Veg',
                          boxColor: _hasfocus2?theme.primaryColor:theme.scaffoldBackgroundColor,
                          textColor: _hasText2?theme.highlightColor:theme.primaryColor,
                        )
                    ),
                    SizedBox(width: size?.wp(2),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          hasFocus=true;
                          unFocus= false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.primaryColor)
                        ),
                        child: Icon(Icons.add,color: theme.primaryColor,size: size?.wp(2),),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Non veg',
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.0225,
                      )
                      ),
                    ),
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
                              padding: const EdgeInsets.only(top:5),
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
                )
              ],
            ),
          ),
          if(hasFocus)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
          if(unFocus)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthButton(textSize: 0.03,text: 'Assign item', action: (){
                  Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabAssignCategory()));
                },
                    textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(46)),
                AuthButton(textSize: 0.03,text: 'Add item', action: (){
                  Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabAddProduct()));
                },
                    textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(46))
              ],
            ),
          ),
          if(hasFocus)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AuthButton(
                    textSize: 0.03,
                    text: 'Cancel',
                    action: () {
                      setState(() {
                        hasFocus=false;
                        unFocus= true;
                      });
                    },
                    textColor: theme.primaryColor,
                    boxColor: theme.scaffoldBackgroundColor,
                    width: size!.wp(46),
                  ),
                  SizedBox(width: size?.wp(4),),
                  AuthButton(
                    textSize: 0.03,
                    text: 'Save',
                    action: () {
                      setState(() {
                        hasFocus=false;
                        unFocus= true;
                      });
                    },
                    textColor: theme.highlightColor,
                    boxColor: theme.primaryColor,
                    width: size!.wp(46),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: TabBottomNavi(
        hasFocus: false,
        hasFocus2: false,
        hasFocus3: false,
      ),
    );
  }
}
