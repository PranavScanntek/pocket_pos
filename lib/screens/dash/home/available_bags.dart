import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/text/appBar_title.dart';
import 'package:pocket_pos/widgets/buttons/back_button.dart';
import 'package:provider/provider.dart';
import '../../../helper/provider_helper/product_provider.dart';
import '../../../model/product_model.dart';
import '../../../widgets/my_bottom.dart';
import 'bag_screen.dart';

class AvailableBagScreen extends StatefulWidget {
  final List<String> names;
  final List<Product> selectedProducts;
  AvailableBagScreen({required this.names,required this.selectedProducts});

  @override
  State<AvailableBagScreen> createState() => _AvailableBagScreenState();
}

class _AvailableBagScreenState extends State<AvailableBagScreen> {
  Screen ? size;

  void navigateToBagScreen(List<Product> selectedProducts,) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BagScreen(selectedProducts: selectedProducts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: PopButton(),
        title: AppBarTitle(text: 'Available bag'),
      ),
      body: widget.names.isNotEmpty?
          ListView.builder(
            itemCount: widget.names.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text('${widget.names[index]}'),
                  onTap: (){
                    navigateToBagScreen(productProvider.selectedProducts);
                  },
                );
              })
      :Center(child: Text('No data',style: TextStyle(color: theme.focusColor),)),
      bottomNavigationBar: MyBottomBar(hasFocus: false, hasFocus2: false, hasFocus3: false, hasFocus4: false, reportSelect: false, scannerSelect: false, homeSelect: false, profile: false),
    );
  }
}
