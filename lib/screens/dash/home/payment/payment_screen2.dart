import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/authButton.dart';
import 'package:pocket_pos/widgets/my_bottom.dart';
import 'package:pocket_pos/widgets/text_container.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../widgets/appBar_title.dart';
import '../../../../widgets/back_button.dart';
import '../../../../widgets/bag_button.dart';
import 'card_screen.dart';

class PaymentScreen2 extends StatefulWidget {
  final double totalAmount;
  PaymentScreen2({required this.totalAmount});
  @override
  State<PaymentScreen2> createState() => _PaymentScreen2State();
}

class _PaymentScreen2State extends State<PaymentScreen2> {
  Screen ? size;
  TextEditingController amountController = TextEditingController();
  TextEditingController dhirhamController = TextEditingController();
  bool showCardButton = false;
  bool isButtonEnabled = false;
  double balanceAmount = 0.0;
  double exchangeRate = 22.68;
  String? selectedCurrency;

  @override
  void initState() {
    super.initState();
    amountController.addListener(updateBalance);
    dhirhamController.addListener(updateBalance);
    loadAmount();
  }
  void loadAmount(){
    setState(() {
      amountController.text=widget.totalAmount.toStringAsFixed(CountryNotifier().selectedCountry == 'Bahrain'?3:2)??'';
    });
  }

  double? updateBalance() {
    final enteredAmount = double.tryParse(amountController.text) ?? 0.0;
    final enteredDhirham= double.tryParse(dhirhamController.text)??0.0;
    setState(() {
      double dhirhamInRupees = enteredDhirham * exchangeRate;
      balanceAmount = widget.totalAmount - (enteredAmount+dhirhamInRupees);
    });
    return null;
  }

  void enableButton() {
    setState(() {
      isButtonEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    void updateUI(double enteredAmount,double enteredDhirham) {
      double total=enteredAmount+enteredDhirham;
      if (total < widget.totalAmount) {
        setState(() {
          showCardButton = true;
        });
      } else {
        setState(() {
          showCardButton = false;
        });
      }
    }

    // Future<void> showCardDialog() async {
    //   await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         backgroundColor: theme.focusColor,
    //         title: Text('Select card',
    //           style: TextStyle(
    //               fontFamily: 'Inter',
    //               fontWeight: FontWeight.w500
    //           ),
    //         ),
    //         content: Container(
    //           height: size?.hp(17),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   TextButton(
    //                       onPressed: (){
    //                       enableButton();
    //                     },
    //                       child: SvgPicture.asset(visa)),
    //                   TextButton(
    //                       onPressed: (){
    //                         enableButton();
    //                       },
    //                       child: SvgPicture.asset(masterCard)),
    //                   TextButton(
    //                       onPressed: (){
    //                         enableButton();
    //                       },
    //                       child: SvgPicture.asset(rupay)),
    //                   TextButton(
    //                       onPressed: (){
    //                         enableButton();
    //                       },
    //                       child: SvgPicture.asset(americanExp)),
    //                 ],
    //               ),
    //               Text("Press confirm after the payment\ncompleted in the swiping\nmachine",
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   fontFamily: 'Inter',
    //                       fontWeight: FontWeight.w500
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         actions: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               AuthButton(text: 'Cancel',
    //                   action: (){
    //                 Navigator.pop(context);
    //               },
    //                   textColor: theme.primaryColor, boxColor: theme.focusColor, width: size!.wp(29)),
    //               SizedBox(width: size?.wp(3),),
    //               AuthButton(text: 'Confirm', action:(){
    //                 Navigator.pop(context);
    //                 showDialog(
    //                   context: context,
    //                   builder: (BuildContext context) {
    //                     return AlertDialog(
    //                       title: CircleAvatar(
    //                         backgroundColor: Colors.greenAccent,
    //                         child: Icon(Icons.check,color: theme.highlightColor,),
    //                       ),
    //                       content: Container(
    //                         height: size?.hp(8),
    //                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
    //                         decoration: BoxDecoration(
    //                             color: theme.primaryColor,
    //                             borderRadius: BorderRadius.circular(10)
    //                         ),
    //                         child: Column(
    //                           children: [
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               children: [
    //                                 Text('Successfully',
    //                                   textAlign: TextAlign.center,
    //                                   style: TextStyle(
    //                                       fontFamily: 'Inter',
    //                                       fontWeight: FontWeight.w700,
    //                                       color: theme.highlightColor
    //                                   ),
    //                                 ),
    //                                 Text(' completed',
    //                                   textAlign: TextAlign.center,
    //                                   style: TextStyle(
    //                                       color: theme.highlightColor
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                             Text('new sale',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   color: theme.highlightColor
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 );
    //               },
    //                   textColor: theme.highlightColor, boxColor:theme.primaryColor, width: size!.wp(29))
    //             ],
    //           ),
    //
    //         ],
    //       );
    //     },
    //   );
    // }
    Future<void> showQrCode() async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: theme.highlightColor,
            title: Container(
              height: 220,
              width: 220,
              child: QrImageView(
                data: 'upi://pay?pa=raffitkm31-1@okhdfcbank&am=${balanceAmount.toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}&pn=Jhon%20Doe&mc=123456&tid=987654321&tr=invoice123&tn=invoice%20Payment',
                version: QrVersions.auto,
                gapless: false,
              ),
            ),
            content: Text('Scan this code',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(26, 26, 26, 1)
              ),
            ),
          );
        },
      );
    }
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
          leading: PopButton(),
          title: AppBarTitle(text: 'Cash pay'),
        actions:[
          Padding(
          padding: const EdgeInsets.only(right: 20),
          child: BagButton()
        ),
    ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: theme.indicatorColor,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                Row(
                  children: [
                    Text('${currencyNotifier.selectedCurrency}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: theme.indicatorColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                      ),
                    ),
                    SizedBox(width: size?.wp(5),),
                    Container(
                      width: size?.wp(40),
                      child: TextContainer(
                          color: theme.focusColor,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            onChanged: (value) {
                              double enteredAmount = double.tryParse(value) ?? 0;
                              double enteredDhirham= double.tryParse(dhirhamController.text)??0;
                              updateUI(enteredAmount,enteredDhirham);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: size?.hp(3),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        hint:Text('Currency',style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: theme.indicatorColor
                        ),), // Hint text
                        value: selectedCurrency,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCurrency = newValue;
                          });
                        },
                        items: [
                          'Rupees',
                          'BD',
                          'AED',
                          'QR',
                          'SR'
                        ].map<DropdownMenuItem<String>>((String? value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value ?? 'export',),
                          );
                        }).toList(),
                      ),
                  ),
                ),
                SizedBox(width: size?.wp(5),),
                Container(
                  width: size?.wp(40),
                  child: TextContainer(
                      color: theme.focusColor,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: dhirhamController,
                        onChanged: (value) {
                          double enteredAmount = double.tryParse(amountController.text) ?? 0;
                          double enteredDhirham= double.tryParse(value)??0;
                          updateUI(enteredAmount,enteredDhirham);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                      )
                  ),
                )
              ],
            ),
            SizedBox(height: size?.hp(3),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Balance',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: theme.indicatorColor,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                Row(
                  children: [
                    Text('${currencyNotifier.selectedCurrency}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: theme.indicatorColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                      ),
                    ),
                    SizedBox(width: size?.wp(5),),
                    Container(
                      width: size?.wp(40),
                      child: TextContainer(
                          color: balanceAmount>0 ? Colors.red : Colors.green,
                          child: Text('${balanceAmount.toStringAsFixed(2)}'),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: size?.hp(3),),
            if (balanceAmount>0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AuthButton(
                    text: 'Card',
                    action: () {
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>CardScreen()));
                    },
                    textColor: theme.primaryColor,
                    boxColor: theme.scaffoldBackgroundColor,
                    width: size!.wp(43),
                  ),
                  AuthButton(
                    text: 'QR Code',
                    action: () {
                      showQrCode();
                    },
                    textColor: theme.highlightColor,
                    boxColor: theme.primaryColor,
                    width: size!.wp(43),
                  ),
                ],
              ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: size?.hp(10),
        color: theme.scaffoldBackgroundColor,
        padding: EdgeInsets.only(bottom: 10),
        child: Align(
          alignment: Alignment.bottomCenter,
            child: balanceAmount>0?SizedBox():AuthButton(text: 'Paid', action: (){}, textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(89))),
      ),
      bottomNavigationBar: MyBottomBar(hasFocus: false, hasFocus2: false, hasFocus3: false, hasFocus4: false, reportSelect: false, scannerSelect: false, homeSelect: false, profile: false),
    );
  }
}
