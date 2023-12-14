import 'package:flutter/material.dart';
import 'package:pocket_pos/screens/tabView/dash/category/TabCategory.dart';
import 'package:pocket_pos/screens/tabView/dash/home/products/TabAllProducts.dart';
import 'package:pocket_pos/screens/tabView/dash/home/products/tab_add_product.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_employee.dart';
import 'package:pocket_pos/screens/tabView/dash/printer.dart';
import 'package:pocket_pos/screens/tabView/dash/profile/tab_profile.dart';
import 'package:pocket_pos/utils/responsive.dart';

class TabDrawer extends StatelessWidget {
  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        children: [
          TabDrawerMenu(name: 'Profile', action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabProfile()));
          }),
          TabDrawerMenu(name: 'All products', action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabAllProducts()));

          }),
          TabDrawerMenu(name: 'Add Products',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabAddProduct()));
          },),
          TabDrawerMenu(name: 'Category',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabCategory()));
          }),
          TabDrawerMenu(name: 'Employees',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabEmployee()));
          }),
          TabDrawerMenu(name: 'Printer',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabPrinter()));
          }),
          // DrawerMenu(name: 'About us')
        ],
      ),
    );
  }
}

class TabDrawerMenu extends StatelessWidget {
  late String name;
  late Function() action;
  TabDrawerMenu({required this.name,required this.action});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: action,
      leading: Text(name,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: MediaQuery.of(context).size.width * 0.02,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
