import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';
import '../../../../../helper/provider_helper/currency_provider.dart';
import '../../../../../helper/provider_helper/product_provider.dart';
import '../../../../../widgets/buttons/authButton.dart';
import '../../../../../widgets/buttons/bag_button.dart';
import '../../../../../widgets/buttons/theme_button.dart';
import '../../../../../widgets/containers/text_container.dart';
import '../../../../../widgets/tabBottomNavi.dart';
import '../../../../../widgets/tab_drawer.dart';
import '../../../../../widgets/text/textWidgets.dart';
import '../tab_bag_screen.dart';

class TabEditProduct extends StatefulWidget {
  const TabEditProduct({super.key});

  @override
  State<TabEditProduct> createState() => _TabEditProductState();
}

class _TabEditProductState extends State<TabEditProduct> {
  Screen ? size;
  String? selectedCategory;
  File? _imageFile;
  TextEditingController barcodeController= TextEditingController();
  TextEditingController productNameController= TextEditingController();
  TextEditingController priceController= TextEditingController();
  TextEditingController costController= TextEditingController();
  TextEditingController stockController= TextEditingController();
  TextEditingController vatController= TextEditingController();
  TextEditingController igstController= TextEditingController();
  TextEditingController cgstController= TextEditingController();
  TextEditingController sgstController= TextEditingController();
  String? result;

  List<String> category=['Veg','Non veg'];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: size?.wp(35),
                    height: size?.hp(30),
                    color: Color.fromRGBO(255, 43, 133, 0.19),
                    child: GestureDetector(
                      onTap: (){
                        _pickImage();
                      },
                      child: _imageFile!=null?
                      Image.file(
                        _imageFile!,
                        width: size?.wp(44),
                        height: size?.hp(14),
                        fit: BoxFit.cover,
                      ):
                      Text('Add photo',
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: 'Inter'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size?.wp(5),),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HintText(text: 'Barcode',textSize: 0.02),
                        TextContainer(
                          color: theme.scaffoldBackgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  result==null?'Scan the product'
                                      :'${result}'
                              ),
                              GestureDetector(
                                onTap: (){
                                  _scanBarcode();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: SvgPicture.asset(scanner,
                                    width: size?.wp(7.5),
                                    height: size?.hp(3),
                                    fit: BoxFit.contain,
                                    color: theme.indicatorColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size?.hp(2),),
                        HintText(text: 'Product name',textSize: 0.02),
                        TextContainer(
                            color: theme.scaffoldBackgroundColor,
                            child: TextFormField(
                              controller: productNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'eg : hand wash 200ml ',
                                helperStyle: TextStyle(
                                    color: theme.hintColor,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size?.wp(46),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HintText(text: 'Price',textSize: 0.02),
                        TextContainer(
                            color: theme.scaffoldBackgroundColor,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size?.wp(46),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HintText(text: 'Cost',textSize: 0.02),
                        TextContainer(
                            color: theme.scaffoldBackgroundColor,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: costController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size?.hp(2),),
              Row(
                children: [
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'Stock count',textSize: 0.02),
                      Container(
                        width:size?.wp(20),
                        child: TextContainer(
                            color: theme.scaffoldBackgroundColor,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: stockController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: size?.wp(3),),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HintText(text: 'Product category',textSize: 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextContainer(
                                  color: theme.scaffoldBackgroundColor,
                                  child: DropdownButton(
                                      hint: const Text('Select category'),
                                      iconDisabledColor: Color.fromRGBO(175, 175, 175, 1),
                                      iconEnabledColor: Color.fromRGBO(175, 175, 175, 1),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      elevation: 0,
                                      value: selectedCategory,
                                      items: category.map((String category){
                                        return DropdownMenuItem<String>(
                                          value: category,
                                          child: Text(category,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue){
                                        setState(() {
                                          selectedCategory=newValue!;
                                        });
                                      }
                                  )
                              ),
                            ),
                            SizedBox(width: size?.wp(3),),
                            Container(
                              width: size?.wp(5),
                              height: size?.hp(6),
                              decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextButton(
                                onPressed: (){},
                                child: SvgPicture.asset(add,color: theme.highlightColor,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size?.hp(2),),
              HintText(text: 'Tax rate',textSize: 0.02),
              (currencyNotifier.selectedCountry=='India')
                  ?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: TextContainer(
                          color: theme.scaffoldBackgroundColor,
                          child: TextFormField(
                            controller: igstController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'IGST %',
                              helperStyle: TextStyle(
                                  color: theme.hintColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: size?.wp(4),),
                  Expanded(
                    child: Container(
                      child: TextContainer(
                          color: theme.scaffoldBackgroundColor,
                          child: TextFormField(
                            controller: cgstController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'CGST %',
                              helperStyle: TextStyle(
                                  color: theme.hintColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ):Container(
                width: size?.wp(48),
                child: TextContainer(
                    color: theme.scaffoldBackgroundColor,
                    child: TextFormField(
                      controller: vatController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'VAT %',
                        helperStyle: TextStyle(
                            color: theme.hintColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(height: size?.hp(2),),
              (currencyNotifier.selectedCountry=='India')
                  ?Container(
                width: size?.wp(46),
                child: TextContainer(
                    color: theme.scaffoldBackgroundColor,
                    child: TextFormField(
                      controller: sgstController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'SGST %',
                        helperStyle: TextStyle(
                            color: theme.hintColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                ),
              ):SizedBox(),
              SizedBox(height: size?.hp(2),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AuthButton(text: 'Cancel', action: (){
                    Navigator.pop(context);
                  },
                      textSize: 0.03,
                      textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(46)),
                  AuthButton(text: 'Save', action: (){
                    Navigator.pop(context);
                  },
                      textSize: 0.03,
                      textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(46))
                ],
              )
            ],
          ),
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
