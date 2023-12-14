import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';

import '../screens/mobileView/dash/home/category/category_screen.dart';
import '../screens/mobileView/dash/home/employees/employee_screen.dart';
import '../screens/mobileView/dash/home/printer/printer_screen.dart';
import '../screens/mobileView/dash/home/product/product_screen.dart';

class DrawerView extends StatelessWidget {
  Screen ? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Business name',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                        color: theme.highlightColor
                    ),
                  ),
                  SizedBox(height: size?.hp(2),),
                  Text('example.eg@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: theme.highlightColor
                    ),
                  )
                ],
              )
          ),
          DrawerMenu(name: 'Add items',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>ProductScreen()));
          },),
          DrawerMenu(name: 'Category',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>CategoryScreen()));
          }),
          DrawerMenu(name: 'Employees',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>EmployeeScreen()));
          }),
          DrawerMenu(name: 'Printer',action: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>PrinterScreen()));

          }),
          // DrawerMenu(name: 'About us')
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  late String name;
  late Function() action;
  DrawerMenu({required this.name,required this.action});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: action,
      leading: Text(name,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}

