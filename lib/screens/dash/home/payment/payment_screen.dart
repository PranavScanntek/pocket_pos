import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/screens/dash/home/payment/card_screen.dart';
import 'package:pocket_pos/screens/dash/home/payment/payment_screen2.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/authButton.dart';
import 'package:pocket_pos/widgets/buttons/bag_button.dart';
import 'package:pocket_pos/widgets/containers/payment_option_tile.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../widgets/text/appBar_title.dart';
import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/my_bottom.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  PaymentScreen({required this.totalAmount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Screen? size;
  bool isButtonEnabled = false;

  void enableButton() {
    setState(() {
      isButtonEnabled = true;
    });
  }
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
        title: AppBarTitle(text: 'Payment'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: BagButton()
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total amount to be paid',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: theme.highlightColor,
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                    Text('${currencyNotifier.selectedCurrency} ${widget.totalAmount.toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}',
                      style: TextStyle(
                        color: theme.highlightColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size?.hp(2.5),),
            PaymentOption(text: 'Cash', image: cash,color: theme.indicatorColor,onPressed: (){
              double totalAmount = productProvider.calculateTotalPrice(productProvider.selectedProducts);
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>PaymentScreen2(totalAmount: totalAmount,)));
            },),
            SizedBox(height: size?.hp(3.5),),
            PaymentOption(text: 'Card', image: card,color: theme.indicatorColor,onPressed: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>CardScreen()));
            }),
            SizedBox(height: size?.hp(3.5),),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border.all(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child:TextButton(onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                backgroundColor: theme.highlightColor,
                content:
                Container(
                  height: size?.hp(53),
                  width: size?.wp(50),
                  child: Column(
                    children: [
                      QrImageView(
                        data: 'upi://pay?pa=raffitkm31-1@okhdfcbank&am=${widget.totalAmount.toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}&pn=Jhon%20Doe&mc=123456&tid=987654321&tr=invoice123&tn=invoice%20Payment',
                        version: QrVersions.auto,
                        gapless: false,
                      ),
                      Text('Scan this code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(26, 26, 26, 1)
                        ),
                      ),
                      SizedBox(height: size?.hp(2),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthButton(text: 'Cancel', action: (){}, textColor: theme.primaryColor, boxColor: theme.highlightColor, width: size!.wp(28)),
                          SizedBox(width: size?.wp(3),),
                          AuthButton(text: 'Done', action: (){}, textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(28))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
            child: Row(
              children: [
                SvgPicture.asset(gpay,height: size?.hp(3.5),width: size?.wp(10)),
              ],
            )),
      ),
            SizedBox(height: size?.hp(3.5),),
            PaymentOption(text: 'Phonepe', image: phonephe,onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    backgroundColor: theme.highlightColor,
                    content:
                    Container(
                      height: size?.hp(53),
                      width: size?.wp(50),
                      child: Column(
                        children: [
                          QrImageView(
                            data: 'upi://pay?pa=raffitkm31-1@okhdfcbank&am=${widget.totalAmount.toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}&pn=Jhon%20Doe&mc=123456&tid=987654321&tr=invoice123&tn=invoice%20Payment',
                            version: QrVersions.auto,
                            gapless: false,
                          ),
                          Text('Scan this code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(26, 26, 26, 1)
                            ),
                          ),
                          SizedBox(height: size?.hp(2),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AuthButton(text: 'Cancel', action: (){}, textColor: theme.primaryColor, boxColor: theme.highlightColor, width: size!.wp(28)),
                              SizedBox(width: size?.wp(3),),
                              AuthButton(text: 'Done', action: (){}, textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(28))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            SizedBox(height: size?.hp(3.5),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                border: Border.all(color: theme.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child:TextButton(onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      backgroundColor: theme.highlightColor,
                      content:
                      Container(
                        height: size?.hp(53),
                        width: size?.wp(50),
                        child: Column(
                          children: [
                            QrImageView(
                              data: 'upi://pay?pa=raffitkm31-1@okhdfcbank&am=${widget.totalAmount.toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}&pn=Jhon%20Doe&mc=123456&tid=987654321&tr=invoice123&tn=invoice%20Payment',
                              version: QrVersions.auto,
                              gapless: false,
                            ),
                            Text('Scan this code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(26, 26, 26, 1)
                              ),
                            ),
                            SizedBox(height: size?.hp(2),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthButton(text: 'Cancel', action: (){}, textColor: theme.primaryColor, boxColor: theme.highlightColor, width: size!.wp(28)),
                                SizedBox(width: size?.wp(3),),
                                AuthButton(text: 'Done', action: (){}, textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(28))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
                  child: Row(
                    children: [
                      SvgPicture.asset(paytm,height: size?.hp(3.5),width: size?.wp(10)),
                    ],
                  )),
            ),
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
