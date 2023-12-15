import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_bag_screen.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_payment.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/tabBottomNavi.dart';
import 'package:pocket_pos/widgets/tabWidget/tabCategoryContainer.dart';
import 'package:pocket_pos/widgets/tab_drawer.dart';
import 'package:provider/provider.dart';
import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../model/product_model.dart';
import '../../../../widgets/buttons/add_button.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/bag_button.dart';
import '../../../../widgets/buttons/decrease_button.dart';
import '../../../../widgets/buttons/delete_button.dart';
import '../../../../widgets/buttons/theme_button.dart';
import '../../../../widgets/containers/text_container.dart';

class TabHomeScreen extends StatefulWidget {
  const TabHomeScreen({super.key});

  @override
  State<TabHomeScreen> createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {
  Screen ? size;
  bool hasToogle=false;
  bool _hasText=true;
  bool _hasText2=false;
  bool _hasfocus=true;
  bool _hasfocus2=false;
  List<String> name =[''];
  List<String> products=[''];
  List<String> enteredNames = [];
  TextEditingController textEditingController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final selectedProduct = productProvider.selectedProductsFiltered;
    final product = productProvider.products;
    List<Product> productList=List.from(product);
    int totalProductCount = product.fold(
        0, (previousValue, product) => previousValue + product.count);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
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
      body: Row(
        children: [
          Container(
            width: size?.wp(60),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        height: size?.hp(7.5),
                        child: TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: theme.shadowColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none
                              ),
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search,color: theme.hintColor,)
                          ),
                          onChanged: (value){
                            setState(() {
                              productList=product.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: size?.hp(2),),
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
                                text: 'All items',
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
                        ],
                      ),
                      SizedBox(height: size?.hp(0.5),),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  color: theme.scaffoldBackgroundColor,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 2,
                        mainAxisExtent: size?.hp(35)
                      ),
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context,int index){
                        final prdts = productList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top:5),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: size?.wp(26),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  (prdts.amount>0)?
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        productProvider.incrementCount(prdts);
                                        productProvider.toggleSelection(prdts);
                                        hasToogle=true;
                                      });
                                    },
                                    child: Image.asset(prdts.image,
                                      width: size?.wp(25),
                                      height: size?.hp(15),
                                      fit: BoxFit.fill,
                                    ),
                                  ): Image.asset(prdts.image,
                                    width: size?.wp(25),
                                    height: size?.hp(15),
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: Text(prdts.name,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: MediaQuery.of(context).size.width * 0.0190,
                                      ),
                                    ),
                                  ),
                                  (prdts.amount>0)?
                                  Text('${currencyNotifier.selectedCurrency} ${prdts.amount}',
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                    ),
                                  ):
                                  GestureDetector(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            backgroundColor: theme.scaffoldBackgroundColor,
                                            title: Text('Enter amount',style: TextStyle(color: theme.indicatorColor),),
                                            content: TextContainer(
                                              color: theme.focusColor,
                                              child: TextFormField(
                                                controller: amountController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AuthButton(text: 'Cancel', action: (){
                                                      Navigator.pop(context);
                                                    },textSize: 0.035, textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(26)),
                                                    SizedBox(width: size?.wp(4),),
                                                    AuthButton(text: 'Done', action: (){
                                                      setState(() {
                                                        prdts.amount =  double.tryParse(amountController.text) ?? 0.0;
                                                      });
                                                      Navigator.pop(context);}, textSize: 0.035,textColor: theme.highlightColor, boxColor: theme.primaryColor, width:size!.wp(26))
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('${currencyNotifier.selectedCurrency} ${prdts.amount}',
                                      style: TextStyle(
                                        color: theme.primaryColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.035,
                                      ),
                                    ),
                                  ),
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
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hasToogle==false||selectedProduct.isEmpty?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(shopping, color: theme.hintColor,
                        colorBlendMode: BlendMode.dstIn,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No ', style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.035,
                              color: theme.hintColor
                          ),),
                          Text('items ', style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.04,
                              color: theme.hintColor

                          ),),
                          Text('here yet!', style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.035,
                              color: theme.hintColor

                          ),),
                        ],
                      )
                    ],
                  ):
                  Container(
                    height:size?.hp(80),
                    child: Column(
                      children: [
                        Container(
                          height:size?.hp(60),
                          child: ListView.builder(
                              itemCount: selectedProduct.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = selectedProduct[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    child: ListTile(
                                      title: Text(selectedProduct[index].name,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.02,
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
                                              .width * 0.03,
                                        ),
                                      ),
                                      trailing: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            product.count >= 2 ?
                                            DecreaseButton(onTap: () {
                                              productProvider.decrementCount(product);
                                            }) : SizedBox(),
                                            SizedBox(width: size?.wp(2),),
                                            Text('${selectedProduct[index].count}',style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.025,
                                            ),),
                                            SizedBox(width: size?.wp(2),),
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
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: size?.hp(25),
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                            color: theme.scaffoldBackgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: size?.hp(10),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Total',
                                            style: TextStyle(
                                              color: theme.indicatorColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: MediaQuery.of(context).size.width * 0.025,
                                            ),
                                          ),

                                          Text('Inclusive tax',
                                            style: TextStyle(
                                              color: theme.indicatorColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context).size.width * 0.02,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text('${currencyNotifier.selectedCurrency} ${productProvider.calculateTotalPrice(productProvider.selectedProducts).toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2)}',
                                        style: TextStyle(
                                          color: theme.indicatorColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context).size.width * 0.0375,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AuthButton(
                                      height: size?.hp(6),
                                        textSize: 0.0180,
                                        width: size!.wp(16),
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
                                                              builder: (context) => TabBagScreen(selectedProducts: productProvider.selectedProducts,names: MyData([enteredName]),),
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
                                        height: size?.hp(6),
                                        width: size!.wp(16),
                                        text: 'Payment',
                                        action: (){
                                          double totalAmount = productProvider.calculateTotalPrice(productProvider.selectedProducts);
                                          Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabPayment(totalAmount: totalAmount,)));
                                        },
                                        textSize: 0.0180,
                                        textColor: theme.highlightColor,
                                        boxColor: theme.primaryColor)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          )
        ],
      ),
      bottomNavigationBar: TabBottomNavi(
        hasFocus: true,
        hasFocus2: false,
        hasFocus3: false,
      ),
    );
  }
}
