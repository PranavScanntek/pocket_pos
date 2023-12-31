import 'package:flutter/material.dart';
import 'package:pocket_pos/helper/provider_helper/product_provider.dart';
import 'package:pocket_pos/screens/mobileView/dash/home/product/product_edit_screen.dart';
import 'package:pocket_pos/widgets/buttons/add_button.dart';
import 'package:pocket_pos/widgets/buttons/edit_button.dart';
import 'package:provider/provider.dart';

import '../../../../../helper/provider_helper/currency_provider.dart';
import '../../../../../utils/responsive.dart';
import '../../../../../widgets/buttons/back_button.dart';
import '../../../../../widgets/my_bottom.dart';
import '../../../../../widgets/text/appBar_title.dart';
import 'add_products_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Screen ? size;
  List<bool>switchValue = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    var productProvider = Provider.of<ProductProvider>(context);
    final product=productProvider.products;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AddButton(
                onTap: (){
                  Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>AddProductsScreen()));
                })
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: product.length,
          itemBuilder: (BuildContext context,int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                color: theme.focusColor,
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                child: ListTile(
                  title: Text(product[index].name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.035,
                    ),
                  ),
                  subtitle: Text('${currencyNotifier.selectedCurrency} ${product[index].amount}',
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
                  leading: Image.asset(product[index].image,
                    width: size?.wp(20),
                    height: size?.hp(8),
                    fit: BoxFit.fill,
                  ),
                  trailing: Container(
                    width: size?.wp(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EditButton(onTap: (){
                          Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>ProductEditScreen()));
                        }),
                        SizedBox(width: size?.wp(5),),
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
                    ),
                  ),
                ),
              ),
            );
          }
                  ),
        bottomNavigationBar:MyBottomBar(
          hasFocus: false,
          hasFocus2: false,
          hasFocus3: false,
          hasFocus4: false,
        )    );
  }
}
