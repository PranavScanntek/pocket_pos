import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/add_button.dart';
import 'package:pocket_pos/widgets/text/appBar_title.dart';

import '../../../../../widgets/buttons/back_button.dart';
import '../../../../../widgets/my_bottom.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({super.key});

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  Screen ? size;
  List<String> printers=['Zebra','Poser','Epson'];
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Printer'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AddButton(onTap: (){})
          ),
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
                        .width * 0.035,
                  ),
                ),
              );
            }
        ),
      ),
        bottomNavigationBar:MyBottomBar(
          hasFocus: false,
          hasFocus2: false,
          hasFocus3: false,
          hasFocus4: false,
        )    );
  }
}
