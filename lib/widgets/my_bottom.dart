import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/utils/responsive.dart';
import '../screens/dash/home/home_screen.dart';
import '../screens/dash/profile/profile_screen.dart';
import '../screens/dash/report/report_screen.dart';
import '../utils/images.dart';

class MyBottomBar extends StatefulWidget {
  late bool hasFocus;
  late bool hasFocus2;
  late bool hasFocus3;
  late bool hasFocus4;
  MyBottomBar({
    required this.hasFocus,
    required this.hasFocus2,
    required this.hasFocus3,
    required this.hasFocus4,

  });

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>HomeScreen()));
              setState(() {
                widget.hasFocus = !widget.hasFocus;
                widget.hasFocus2 = false;
                widget.hasFocus3 = false;
                widget.hasFocus4 = false;

              });
            },
            child: NavigationContainer(
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
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>ReportScreen()));
              setState(() {
                widget.hasFocus2= !widget.hasFocus2;
                widget.hasFocus = false;
                widget.hasFocus3 = false;
                widget.hasFocus4 = false;
              });
            },
            child: NavigationContainer(
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
                widget.hasFocus4 = false;

              });
            },
            child: NavigationContainer(
              color: widget.hasFocus3?theme.primaryColor:theme.focusColor,

              icon: SvgPicture.asset(scanner,
                height: size?.hp(4),
                width: size?.wp(8),
                color: widget.hasFocus3?theme.highlightColor:theme.indicatorColor,

              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>Profile_screen()));
              setState(() {
                widget.hasFocus4= !widget.hasFocus4;
                widget.hasFocus2 = false;
                widget.hasFocus3 = false;
                widget.hasFocus = false;
              });
            },
            child: NavigationContainer(
              color: widget.hasFocus4?theme.primaryColor:theme.focusColor,
              icon: SvgPicture.asset(profile,
                height: size?.hp(4),
                width: size?.wp(8),
                color: widget.hasFocus4?theme.highlightColor:theme.indicatorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationContainer extends StatefulWidget {
  late Widget icon;
  late Color color;
  NavigationContainer({required this.icon,required this.color});

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {

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
