import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../utils/images.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/appBar_title.dart';
import '../../../../widgets/authButton.dart';
import '../../../../widgets/back_button.dart';
import '../../../../widgets/my_bottom.dart';
import '../../../../widgets/textWidgets.dart';
import '../../../../widgets/text_container.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({super.key});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
    Screen ? size;
    String? selectedCategory;
    String selectedValue = 'Each';
    File? _imageFile;
    TextEditingController barcodeController = TextEditingController();
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
    appBar: AppBar(
    backgroundColor: theme.scaffoldBackgroundColor,
    elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Edit products'),
    ),
    body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Container(
              alignment: Alignment.center,
              width: size?.wp(44),
              height: size?.hp(14),
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
          SizedBox(height: size?.hp(2),),
          HintText(text: 'Barcode'),
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
              )
          ),
      SizedBox(height: size?.hp(2),),
      HintText(text: 'Product name'),
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
      SizedBox(height: size?.hp(2),),
      HintText(text: 'Product category'),
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
      underline: const SizedBox(),
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
      SizedBox(width: size?.wp(7),),
      Container(
      width: size?.wp(7),
      height: size?.hp(4),
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
      )
      ],
      ),
      SizedBox(height: size?.hp(2),),
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Container(
      width: size?.wp(42),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      HintText(text: 'Product Price'),
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
      width: size?.wp(42),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      HintText(text: 'Selling Price'),
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
      HintText(text: 'Stock count'),
      Container(
      width: size?.wp(42),
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
      SizedBox(height: size?.hp(2),),
          HintText(text: 'Tax rate'),
          (currencyNotifier.selectedCountry=='India')
              ?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Container(
                      width: size?.wp(42),
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
                  Container(
                      width: size?.wp(42),
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
              ],
          ):Container(
              width: size?.wp(42),
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
              width: size?.wp(42),
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
          textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(43)),
          AuthButton(text: 'Save', action: (){
              Navigator.pop(context);
          },
              textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(43))
        ],
      )
      ],
      ),
    ),
    ),
    bottomNavigationBar: MyBottomBar(hasFocus: false, hasFocus2: false, hasFocus3: false, hasFocus4: false, reportSelect: false, scannerSelect: false, homeSelect: false, profile: false),

    );
  }
}
