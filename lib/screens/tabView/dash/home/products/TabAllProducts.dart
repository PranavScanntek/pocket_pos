import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_pos/screens/tabView/dash/home/products/tab_product_edit.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../../../../helper/provider_helper/currency_provider.dart';
import '../../../../../helper/provider_helper/product_provider.dart';
import '../../../../../model/product_model.dart';
import '../../../../../widgets/buttons/bag_button.dart';
import '../../../../../widgets/buttons/theme_button.dart';
import '../../../../../widgets/containers/text_container.dart';
import '../../../../../widgets/tabBottomNavi.dart';
import '../../../../../widgets/tab_drawer.dart';
import '../tab_bag_screen.dart';

class TabAllProducts extends StatefulWidget {
  const TabAllProducts({super.key});

  @override
  State<TabAllProducts> createState() => _TabAllProductsState();
}

class _TabAllProductsState extends State<TabAllProducts> {
  Screen ? size;
  List<bool>switchValue = List.generate(2, (index) => false);
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
              height: size?.hp(70),
              color: theme.scaffoldBackgroundColor,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 4,
                    childAspectRatio: .55,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabEditProduct()));
                                    },
                                      child: SvgPicture.asset(edit,color: theme.indicatorColor,height: size?.hp(4),)),
                                  Switch(
                                    activeColor: theme.primaryColor,
                                    activeTrackColor: Color.fromRGBO(232, 232, 232, 1),
                                    inactiveThumbColor: theme.indicatorColor,
                                    inactiveTrackColor: Color.fromRGBO(232, 232, 232, 1),
                                    value: switchValue[index],
                                    onChanged: (value) {
                                      setState(() {
                                        switchValue[index] = value;
                                      });
                                    },
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
      ),
      bottomNavigationBar: TabBottomNavi(
        hasFocus: false,
        hasFocus2: false,
        hasFocus3: false,
      ),
    );
  }
}
