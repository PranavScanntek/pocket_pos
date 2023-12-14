import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';
import '../../../helper/provider_helper/product_provider.dart';
import '../../../widgets/buttons/bag_button.dart';
import '../../../widgets/buttons/theme_button.dart';
import '../../../widgets/tabBottomNavi.dart';
import '../../../widgets/tab_drawer.dart';
import 'home/tab_bag_screen.dart';

class TabPrinter extends StatefulWidget {
  const TabPrinter({super.key});

  @override
  State<TabPrinter> createState() => _TabPrinterState();
}

class _TabPrinterState extends State<TabPrinter> {

  Screen ? size;
  List<String> printers=['Zebra','Poser','Epson'];
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
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
          padding: const EdgeInsets.symmetric(horizontal:10),
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context,index){
                return ListTile(
                  onTap: (){},
                  title: Text(printers[index],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.0225,
                    ),
                  ),
                );
              }
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
