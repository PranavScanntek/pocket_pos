import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/screens/dash/home/order_details_screen.dart';
import 'package:pocket_pos/screens/dash/home/available_bags.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/bag_button.dart';
import 'package:pocket_pos/widgets/category_container.dart';
import 'package:pocket_pos/widgets/drawer_view.dart';
import 'package:pocket_pos/widgets/theme_button.dart';
import 'package:provider/provider.dart';
import '../../../helper/provider_helper/currency_provider.dart';
import '../../../helper/provider_helper/product_provider.dart';
import '../../../widgets/authButton.dart';
import '../../../widgets/my_bottom.dart';
import '../../../widgets/text_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Screen ? size;
  bool _hasText=true;
  bool _hasText2=false;
  bool _hasfocus=true;
  bool _hasfocus2=false;
  List<String> name =[''];

  List<String> products=[''];

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.products;
    int totalProductCount = product.fold(
        0, (previousValue, product) => previousValue + product.count);
    return Scaffold(
      drawer: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DrawerView(),
      ),
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: theme.indicatorColor, // Change the icon color here
              ),
              onPressed: () {
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
              action: (){
                final productProvider = Provider.of<ProductProvider>(context, listen: false);
                Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>AvailableBagScreen(selectedProducts:productProvider.selectedProducts,names: name,)));              },
            )
          ),
          ThemedButton()
          ],
    ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  child:SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          elevation: MaterialStateProperty.all(3),
                          shadowColor: MaterialStateProperty.all(theme.shadowColor),
                          hintText: 'Search',
                          overlayColor: MaterialStateProperty.all(Colors.white),
                          hintStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w400)),
                          shape: MaterialStateProperty.all(const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          )),
                          controller: controller,
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search,color: Color.fromRGBO(41, 41, 41, 0.5),),
                        );
                      }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(products.length, (int index) {
                      final String item =  products[index];
                      return ListTile(
                        tileColor: theme.focusColor,
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  }
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
                        child: CategoryContainer(
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
                        child: CategoryContainer(
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
            height: size?.hp(60),
            color: theme.scaffoldBackgroundColor,
            child: ListView.builder(
              itemCount: product.length,
                itemBuilder: (BuildContext context,int index){
                  final prdts = product[index];
                  return Padding(
                    padding: const EdgeInsets.only(top:5),
                    child: Container(
                      color: theme.focusColor,
                      padding: EdgeInsets.all(5),
                      child: ListTile(
                        tileColor: theme.focusColor,
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(prdts.name,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                        ),
                        subtitle: (prdts.amount>0)?
                        Text('${currencyNotifier.selectedCurrency} ${prdts.amount}',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ):
                        GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
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
                                          }, textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(26)),
                                          SizedBox(width: size?.wp(3),),
                                          AuthButton(text: 'Done', action: (){
                                            setState(() {
                                              prdts.amount =  double.tryParse(amountController.text) ?? 0.0;
                                            });
                                            Navigator.pop(context);}, textColor: theme.highlightColor, boxColor: theme.primaryColor, width:size!.wp(26))
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
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                            ),
                          ),
                        ),
                        leading: InkWell(
                          onTap: (){
                            setState(() {
                              productProvider.incrementCount(prdts);
                              productProvider.toggleSelection(prdts);
                            });
                          },
                          child: Image.asset(prdts.image,
                            width: size?.wp(18),
                            height: size?.hp(8),
                            fit: BoxFit.fill,
                          ),
                        ),
                        trailing: Container(
                          width: size?.wp(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${prdts.count}',
                                textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                              ),
                              SizedBox(width: size?.wp(5),),
                              InkWell(
                                onTap: (){
                                  productProvider.decrementCount(prdts);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: size?.wp(7.5),
                                  height: size?.hp(4.5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: theme.primaryColor),
                                  ),
                                  child: Container(
                                    width: 15,
                                    child: SvgPicture.asset(minus,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                ),
          )
        ],
      ),
      bottomSheet: Container(
        height: size?.hp(20),
        color: theme.scaffoldBackgroundColor,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                final productProvider = Provider.of<ProductProvider>(context, listen: false);
                Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>OrderDetailsScreen(selectedProducts: productProvider.selectedProductsFiltered,)));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('Items ',
                              style: TextStyle(
                                color: theme.highlightColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                            Text( '$totalProductCount',
                              style: TextStyle(
                                  color: theme.highlightColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size?.hp(1),),
                        Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Total ',
                                      style: TextStyle(
                                        color: theme.highlightColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: MediaQuery.of(context).size.width * 0.035,
                                      ),
                                    ),
                                    Text(productProvider.calculateTotalPrice(productProvider.selectedProducts).toStringAsFixed(currencyNotifier.selectedCountry == 'Bahrain'?3:2),
                                      style: TextStyle(
                                        color: theme.highlightColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                                Text('inclusive tax',
                                  style: TextStyle(
                                      color: theme.highlightColor,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(context).size.width * 0.03,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Continue',
                          style: TextStyle(
                              color: theme.highlightColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ),
                        SizedBox(width: size?.wp(1),),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: theme.highlightColor,
                            shape: BoxShape.circle
                          ),
                            child: Icon(Icons.arrow_forward,color: theme.primaryColor,size: 15,))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(
        hasFocus: true,homeSelect: true,
        hasFocus2: false,reportSelect: false,
        hasFocus3: false,scannerSelect: false,
        hasFocus4: false,profile: false,
      ),
    );
  }
}
