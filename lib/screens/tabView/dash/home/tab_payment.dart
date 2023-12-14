import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_bag_screen.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../utils/images.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/bag_button.dart';
import '../../../../widgets/buttons/theme_button.dart';
import '../../../../widgets/containers/text_container.dart';
import '../../../../widgets/tabBottomNavi.dart';
import '../../../../widgets/tab_drawer.dart';

class TabPayment extends StatefulWidget {
  late double totalAmount;

  TabPayment({required this.totalAmount});

  @override
  State<TabPayment> createState() => _TabPaymentState();
}

class _TabPaymentState extends State<TabPayment> {
  Screen ? size;
  bool hasCash=true;
  bool hasCard=false;
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
    final productProvider = Provider.of<ProductProvider>(context);
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
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: Row(
          children: [
            Container(
              width: size?.wp(48),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total amount to be paid',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: theme.indicatorColor,
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                        Text('${currencyNotifier.selectedCurrency} ${widget.totalAmount.toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}',
                          style: TextStyle(
                            color: theme.indicatorColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            hasCash=true;
                            hasCard=false;
                          });
                        },
                        child: Container(
                          width:size?.wp(23),
                          padding: EdgeInsets.symmetric(),
                          decoration:BoxDecoration(
                            border: Border(bottom: BorderSide(
                                color: hasCash==true?theme.primaryColor:theme.scaffoldBackgroundColor,width: 2))
                          ),
                          child: Text('Cash',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: hasCash==true?theme.primaryColor:theme.indicatorColor,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            hasCard=true;
                            hasCash=false;
                          });
                        },
                        child: Container(
                          width:size?.wp(23),
                          padding: EdgeInsets.symmetric(),
                          decoration:BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color:hasCard==true? theme.primaryColor:theme.scaffoldBackgroundColor,width: 2))
                          ),
                          child: Text('Card',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: hasCard==true?theme.primaryColor:theme.indicatorColor,
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                            ),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child:
                        hasCash==true&& hasCard==false?
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: theme.indicatorColor,
                                fontSize: MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                            Row(
                              children: [
                                Text('${currencyNotifier.selectedCurrency}',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: theme.indicatorColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.025,
                                  ),
                                ),
                                Container(
                                  width: size?.wp(29),
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
                                      color: theme.indicatorColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.018,
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
                                      child: Text(value ?? 'export',style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: theme.indicatorColor,
                                        fontSize: MediaQuery.of(context).size.width * 0.018,
                                      ),),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Container(
                              width: size?.wp(29),
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
                                fontSize: MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                            Row(
                              children: [
                                Text('${currencyNotifier.selectedCurrency}',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: theme.indicatorColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.025,
                                  ),
                                ),
                                SizedBox(width: size?.wp(4),),
                                Container(
                                  width: size?.wp(29),
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
                                textSize: 0.025,
                                text: 'Card',
                                action: () {
                                  // Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>CardScreen()));
                                },
                                textColor: theme.primaryColor,
                                boxColor: theme.scaffoldBackgroundColor,
                                width: size!.wp(20),
                              ),
                              AuthButton(
                                textSize: 0.025,
                                text: 'QR Code',
                                action: () {
                                  showQrCode();
                                },
                                textColor: theme.highlightColor,
                                boxColor: theme.primaryColor,
                                width: size!.wp(20),
                              ),
                            ],
                          ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: balanceAmount>0?SizedBox():AuthButton(textSize: 0.025,text: 'Paid', action: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    title: CircleAvatar(
                                      backgroundColor: Colors.greenAccent,
                                      child: Icon(Icons.check,color: theme.highlightColor,),
                                    ),
                                    content: Container(
                                      height: size?.hp(8),
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                      decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Successfully',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    color: theme.highlightColor
                                                ),
                                              ),
                                              Text(' completed',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: theme.highlightColor
                                                ),
                                              )
                                            ],
                                          ),
                                          Text('new sale',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: theme.highlightColor
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }, textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(89))),
                      ],
                    ):Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Select card',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                fontSize: MediaQuery.of(context).size.width * 0.025,
                              ),
                            ),
                            SizedBox(height: size?.hp(3),),
                            Center(
                              child: Container(
                                width: size?.wp(46),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(onTap:(){},child: SvgPicture.asset(visa)),
                                    GestureDetector(onTap:(){},child: SvgPicture.asset(masterCard)),
                                    GestureDetector(onTap:(){},child: SvgPicture.asset(rupay)),
                                    GestureDetector(onTap:(){},child: SvgPicture.asset(americanExp)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size?.hp(3),),
                            Center(
                              child: Text("Press confirm after the payment\ncompleted in the swiping\nmachine",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.of(context).size.width * 0.025,
                                    color: theme.indicatorColor
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthButton(text: 'Cancel', action: (){
                                  Navigator.pop(context);
                                },textSize: 0.025,
                                    textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(20)),
                                AuthButton(text: 'Confirm',textSize: 0.025, action: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        title: CircleAvatar(
                                          backgroundColor: Colors.greenAccent,
                                          child: Icon(Icons.check,color: theme.highlightColor,),
                                        ),
                                        content: Container(
                                          height: size?.hp(8),
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                          decoration: BoxDecoration(
                                              color: theme.primaryColor,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('Successfully',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w700,
                                                        color: theme.highlightColor
                                                    ),
                                                  ),
                                                  Text(' completed',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: theme.highlightColor
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text('new sale',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: theme.highlightColor
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                    textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(20))
                              ],
                            ),
                          ],
                        ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              width: size?.wp(45),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(phonepay,height: size?.hp(8),),
                      SizedBox(width: size?.wp(3),),
                      SvgPicture.asset(gpay,height: size?.hp(8),)
                    ],
                  ),
                  Center(
                    child: Container(
                      color: theme.highlightColor,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(3),
                      child: QrImageView(
                        data: 'upi://pay?pa=raffitkm31-1@okhdfcbank&am=${widget.totalAmount.toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}&pn=Jhon%20Doe&mc=123456&tid=987654321&tr=invoice123&tn=invoice%20Payment',
                        version: QrVersions.auto,
                        gapless: false,
                      ),
                    ),
                  ),
                ],
              ),
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
