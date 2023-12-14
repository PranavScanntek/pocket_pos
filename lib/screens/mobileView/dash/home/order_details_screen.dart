import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/mobileView/dash/home/payment/payment_screen.dart';
import 'package:pocket_pos/widgets/buttons/add_button.dart';
import 'package:pocket_pos/widgets/buttons/authButton.dart';
import 'package:pocket_pos/widgets/buttons/bag_button.dart';
import 'package:pocket_pos/widgets/buttons/decrease_button.dart';
import 'package:pocket_pos/widgets/buttons/delete_button.dart';
import 'package:pocket_pos/widgets/containers/text_container.dart';
import 'package:provider/provider.dart';

import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../model/product_model.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/my_bottom.dart';
import '../../../../widgets/text/appBar_title.dart';
import 'available_bags.dart';

class OrderDetailsScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  OrderDetailsScreen({required this.selectedProducts});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Screen ? size;
  TextEditingController textEditingController = TextEditingController();
  String name = '';
  List<String> enteredNames = [];


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final selectedProduct = productProvider.selectedProductsFiltered;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Billing'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: BagButton()
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: selectedProduct.length,
          itemBuilder: (context,index){
            final product = selectedProduct[index];
            if(product.count==0){
              return Center(child: Text('No Data'),);
            }else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: theme.focusColor,
                  padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: ListTile(
                    tileColor: theme.focusColor,
                    title: Text(selectedProduct[index].name,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.035,
                      ),
                    ),
                    subtitle: Text('${currencyNotifier
                        .selectedCurrency} ${selectedProduct[index].amount}',
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
                    trailing: Container(
                      width: size?.wp(40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          product.count >= 2 ?
                          DecreaseButton(onTap: () {
                            productProvider.decrementCount(product);
                          }) : SizedBox(),
                          Text('${selectedProduct[index].count}'),
                          SizedBox(width: size?.wp(3),),
                          AddButton(onTap: () {
                            productProvider.incrementCount(product);
                          }),
                          SizedBox(width: size?.wp(4),),
                          DeleteButton(onTap: () {
                            productProvider.removeSelectedProduct(index);
                          })
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
      bottomSheet: productProvider.calculateTotalPrice(productProvider.selectedProducts).toStringAsFixed(2)=='0.00'?
      SizedBox()
      :Container(
        width: double.infinity,
        height: size?.hp(20),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        color: theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: size?.hp(9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.scaffoldBackgroundColor,
          border: Border.all(color: theme.primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total',
                  style: TextStyle(
                    color: theme.indicatorColor,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),

                Text('Inclusive tax',
                  style: TextStyle(
                    color: theme.indicatorColor,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                  ),
                ),
              ],
            ),
            Text('${currencyNotifier.selectedCurrency} ${productProvider.calculateTotalPrice(productProvider.selectedProducts).toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}',
              style: TextStyle(
                color: theme.indicatorColor,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            )
          ],
        ),
      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthButton(
                    textSize: 0.035,
                    width: size!.wp(43),
                    text: 'Add to bag',
                    action: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 5,
                            backgroundColor: theme.scaffoldBackgroundColor,
                            title: Text('Enter name',style: TextStyle(color: theme.indicatorColor),),
                            content: TextContainer(
                              color: theme.focusColor,
                              child: TextFormField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AuthButton(text: 'Cancel', action: (){
                                    Navigator.pop(context);
                                  }, textSize: 0.035,textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(26)),
                                  SizedBox(width: size?.wp(3),),
                                  AuthButton(text: 'Done', action: (){
                                    final enteredName = textEditingController.text;
                                    if (enteredName.isNotEmpty) {
                                      setState(() {
                                        enteredNames.add(enteredName);
                                      });
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                        builder: (context) => AvailableBagScreen(selectedProducts: productProvider.selectedProducts,names: enteredNames,),
                                    ));
                                  },textSize: 0.035, textColor: theme.highlightColor, boxColor: theme.primaryColor, width:size!.wp(26))
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    textColor: theme.primaryColor,
                    boxColor: theme.focusColor),
                AuthButton(
                    width: size!.wp(43),
                    text: 'Payment',
                    action: (){
                      double totalAmount = productProvider.calculateTotalPrice(productProvider.selectedProducts);
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>PaymentScreen(totalAmount: totalAmount,)));
                    },
                    textSize: 0.035,
                    textColor: theme.highlightColor,
                    boxColor: theme.primaryColor)
              ],
            )
          ],
        ),
      ),
        bottomNavigationBar:MyBottomBar(
          hasFocus: false,
          hasFocus2: false,
          hasFocus3: false,
          hasFocus4: false,
        )
    );
  }
}
