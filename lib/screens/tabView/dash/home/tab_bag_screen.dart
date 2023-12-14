import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/back_button.dart';
import 'package:provider/provider.dart';
import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../model/product_model.dart';
import '../../../../widgets/buttons/add_button.dart';
import '../../../../widgets/buttons/bag_button.dart';
import '../../../../widgets/buttons/decrease_button.dart';
import '../../../../widgets/buttons/delete_button.dart';
import '../../../../widgets/buttons/theme_button.dart';
import '../../../../widgets/tabBottomNavi.dart';
import '../../../../widgets/tab_drawer.dart';

class TabBagScreen extends StatefulWidget {
  final MyData? names;
  final List<Product>? selectedProducts;
  TabBagScreen({ this.names, this.selectedProducts});

  @override
  State<TabBagScreen> createState() => _TabBagScreenState();
}

class _TabBagScreenState extends State<TabBagScreen> {
  Screen ? size;
  bool hasSelect=false;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    final productProvider = Provider.of<ProductProvider>(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
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
      body: widget.names==null&&widget.selectedProducts==null?
          Center(child: Text('Empty data',style: TextStyle(color: theme.indicatorColor),),)
      :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: size?.wp(53),
              child: ListView(
                children: [
                  Row(
                    children: [
                      PopButton(),
                      Text('Available bags',
                        style: TextStyle(
                          color: theme.indicatorColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                      // onChanged: (value){
                      //   setState(() {
                      //     productList=product.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
                      //   });
                      // },
                    ),
                  ),
                  widget.names==null?
                      Center(child: Text('No data',style: TextStyle(color: theme.indicatorColor),))
                  :Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: widget.names!.dataList.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              tileColor: hasSelect==true?Color.fromRGBO(255, 43, 133, 0.19):theme.scaffoldBackgroundColor,
                              title: Text('${widget.names!.dataList[index]}'),
                              onTap: (){
                                setState(() {
                                  hasSelect=true;
                                });
                              },
                            ),
                          );
                        }),
                  )


                ],
              ),
            ),
            Container(
              width: size?.wp(40),
              child: widget.selectedProducts==null?
              Center(child: Text('No data',style: TextStyle(color: theme.indicatorColor),))
              : hasSelect==true?
              ListView.builder(
                  itemCount: widget.selectedProducts!.length,
                  itemBuilder: (context,index){
                    final product=widget.selectedProducts![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: ListTile(
                        title: Text(widget.selectedProducts![index].name,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width * 0.0225,
                          ),
                        ),
                        subtitle: Text('${currencyNotifier.selectedCurrency} ${widget.selectedProducts![index].amount}',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                        trailing: Container(
                          width: size?.wp(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              product.count>=2?
                              DecreaseButton(onTap: (){
                                productProvider.decrementCount(product);
                              }):SizedBox(),
                              Text('${product.count}',style: TextStyle(
                                color: theme.indicatorColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context).size.width * 0.0225,
                              ),),
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
                    );
                  }):Center(child: Text('No data',style: TextStyle(color: theme.indicatorColor),))
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

class MyData {
  final List<String> dataList;

  MyData(this.dataList);
}
