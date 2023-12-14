import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_home.dart';
import 'package:pocket_pos/screens/tabView/dash/report.dart';
import 'package:pocket_pos/utils/responsive.dart';

import '../utils/images.dart';

class TabBottomNavi extends StatefulWidget {
  late bool hasFocus;
  late bool hasFocus2;
  late bool hasFocus3;
  TabBottomNavi({
    required this.hasFocus,
    required this.hasFocus2,
    required this.hasFocus3,
  });

  @override
  State<TabBottomNavi> createState() => _TabBottomNaviState();
}

class _TabBottomNaviState extends State<TabBottomNavi> {

  Screen ? size;
  String? result;

  Future<void> _scanBarcode() async {
    String result;
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.BARCODE
      );
    } on PlatformException {
      result = 'Failed to get platform version.';
    }
    if(!mounted) return;
    setState((){this.result=result;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      color: theme.scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabHomeScreen()));
              setState(() {
                widget.hasFocus = !widget.hasFocus;
                widget.hasFocus2 = false;
                widget.hasFocus3 = false;
              });
            },
            child: TabNavigationContainer(
              color: widget.hasFocus?theme.primaryColor:theme.focusColor,
              icon: SvgPicture.asset(home,
                height: size?.hp(4),
                width: size?.wp(8),
                color:  widget.hasFocus?theme.highlightColor:theme.indicatorColor,
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>TabReport()));
              setState(() {
                widget.hasFocus2= !widget.hasFocus2;
                widget.hasFocus = false;
                widget.hasFocus3 = false;
              });
            },
            child: TabNavigationContainer(
              color: widget.hasFocus2?theme.primaryColor:theme.focusColor,
              icon: SvgPicture.asset(report,
                height: size?.hp(4),
                width: size?.wp(8),
                color: widget.hasFocus2?theme.highlightColor:theme.indicatorColor,
              ),
            ),
          ),
          InkWell(
            onTap: (){
              _scanBarcode();
              setState(() {
                widget.hasFocus3= !widget.hasFocus3;
                widget.hasFocus2 = false;
                widget.hasFocus = false;
              });
            },
            child: TabNavigationContainer(
              color: widget.hasFocus3?theme.primaryColor:theme.focusColor,

              icon: SvgPicture.asset(scanner,
                height: size?.hp(4),
                width: size?.wp(8),
                color: widget.hasFocus3?theme.highlightColor:theme.indicatorColor,

              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabNavigationContainer extends StatefulWidget {
  late Widget icon;
  late Color color;
  TabNavigationContainer({required this.icon,required this.color});

  @override
  State<TabNavigationContainer> createState() => _TabNavigationContainerState();
}

class _TabNavigationContainerState extends State<TabNavigationContainer> {

  Screen ? size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Focus(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
        height: size?.hp(5),
        width: size?.wp(11.5),
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10)
        ),
        child: widget.icon,
      ),
    );
  }
}
