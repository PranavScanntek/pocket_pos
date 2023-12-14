import 'package:flutter/material.dart';
import 'package:pocket_pos/model/product_model.dart';
import 'package:pocket_pos/screens/mobileView/dash/home/payment/payment_screen.dart';
import 'package:pocket_pos/widgets/buttons/add_button.dart';
import 'package:pocket_pos/widgets/buttons/decrease_button.dart';
import 'package:pocket_pos/widgets/buttons/delete_button.dart';
import 'package:provider/provider.dart';
import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/my_bottom.dart';
import '../../../../widgets/text/appBar_title.dart';

class BagScreen extends StatefulWidget {

  final List<Product> selectedProducts;
  BagScreen({required this.selectedProducts});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  Screen ? size;


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    final productProvider = Provider.of<ProductProvider>(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Bag'),
      ),
      body: widget.selectedProducts.isNotEmpty?
      ListView.builder(
          itemCount: widget.selectedProducts.length,
          itemBuilder: (context,index){
            final product=widget.selectedProducts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: theme.focusColor,
                padding: EdgeInsets.all(5),
                child: ListTile(
                  tileColor: theme.focusColor,
                  title: Text(widget.selectedProducts[index].name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    ),
                  ),
                  subtitle: Text('${currencyNotifier.selectedCurrency} ${widget.selectedProducts[index].amount}',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                  trailing: Container(
                    width: size?.wp(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        product.count>=2?
                        DecreaseButton(onTap: (){
                          productProvider.decrementCount(product);
                        }):SizedBox(),
                        Text('${product.count}'),
                        AddButton(onTap: (){
                          productProvider.incrementCount(product);
                        }),
                        DeleteButton(onTap: (){
                          productProvider.removeSelectedProduct(index);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }):Text('no data',style: TextStyle(color: theme.indicatorColor),),
      bottomSheet:widget.selectedProducts.isNotEmpty?
      Container(
        width: double.infinity,
        height: size?.hp(22),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        color: theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: size?.wp(89),
              height: size?.hp(9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.focusColor,
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
            AuthButton(
                width: size!.hp(89),
                text: 'Payment',
                textSize: 0.035,
                action: (){
                  double totalAmount = productProvider.calculateTotalPrice(productProvider.selectedProducts);
                  Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>PaymentScreen(totalAmount: totalAmount,)));
                },
                textColor: theme.highlightColor,
                boxColor: theme.primaryColor)
          ],
        ),
      ):SizedBox(),
        bottomNavigationBar:MyBottomBar(
          hasFocus: false,
          hasFocus2: false,
          hasFocus3: false,
          hasFocus4: false,
        )
    );
  }
}
