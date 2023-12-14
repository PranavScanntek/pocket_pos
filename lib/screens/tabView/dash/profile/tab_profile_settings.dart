import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../../../helper/provider_helper/currency_provider.dart';
import '../../../../helper/provider_helper/product_provider.dart';
import '../../../../model/country_model.dart';
import '../../../../utils/images.dart';
import '../../../../widgets/buttons/authButton.dart';
import '../../../../widgets/buttons/bag_button.dart';
import '../../../../widgets/buttons/theme_button.dart';
import '../../../../widgets/containers/auth_field.dart';
import '../../../../widgets/containers/text_container.dart';
import '../../../../widgets/tabBottomNavi.dart';
import '../../../../widgets/tab_drawer.dart';
import '../../../../widgets/text/textWidgets.dart';
import '../home/tab_bag_screen.dart';

class TabProfileSettings extends StatefulWidget {
  const TabProfileSettings({super.key});

  @override
  State<TabProfileSettings> createState() => _TabProfileSettingsState();
}

class _TabProfileSettingsState extends State<TabProfileSettings> {
  Screen ? size;
  bool visibility = false;
  String selectedValue = "+91";
  String selectedCurrency='\u{20B9} Rupees';
  File? _imageFile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController landLineController= TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  String selectedCountry='Select a country';
  String countryFlag= blank;
  List<String> selectedItems = [];
  String? selectedItem;

  List<Country> countries = [
    Country(name: 'Select a country', flagImagePath: blank),
    Country(name:'India', flagImagePath: india),
    Country(name:'UAE', flagImagePath:uae),
    Country(name:'KSA', flagImagePath:ksa),
    Country(name:'Bahrain', flagImagePath:baharain),
    Country(name:'Qatar', flagImagePath:qatar),
  ];
  List<String> dropdownItems = ["+91", "+971", "+973", "+974","+966"];
  List<String> currencySymbol=['\u{20B9} Rupees','\u{062F}.\u{002E}\u{0625} Dirham','\u{062F}.\u{002E} Dinar','\u{0631}.\u{002E}\u{0642} Qatar riyal','\u{0631}.\u{002E}\u{0633} Saudi riyal'];

  void toggleVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('image', pickedFile.path);
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 43, 133, 0.19),
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        _pickImage();
                      },
                      child: _imageFile!=null?
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(
                          _imageFile!,
                        ),
                      ):
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Color.fromRGBO(255, 43, 133, 0.19),
                        child: Text('Add photo',
                          style: TextStyle(
                              color: theme.primaryColor,
                              fontFamily: 'Inter',
                            fontSize: MediaQuery.of(context).size.width * 0.025,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size?.wp(3),),
                  Container(
                    height: size?.hp(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HintText(text: 'Business name',textSize: 0.02),
                        TextContainer(
                          width: size?.wp(60),
                          color: theme.scaffoldBackgroundColor,
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: size?.hp(1),),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HintText(text: 'Email ID',textSize: 0.02),
                                  TextContainer(
                                    width: size?.wp(29),
                                    color: theme.scaffoldBackgroundColor,
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: size?.wp(2),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HintText(text: 'Password',textSize: 0.02),
                                  TextContainer(
                                    width: size?.wp(29),
                                    color: theme.scaffoldBackgroundColor,
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: !visibility,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                              icon: Icon(!visibility?Icons.visibility_outlined:Icons.visibility,color: !visibility?theme.hintColor:theme.hintColor),
                                              onPressed: toggleVisibility
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size?.hp(1),),
              HintText(text: 'Address line 1',textSize: 0.02),
              TextContainer(
                color: theme.scaffoldBackgroundColor,
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size?.hp(1),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'City',textSize: 0.02),
                      TextContainer(
                        width: size?.wp(46),
                        color: theme.scaffoldBackgroundColor,
                        child: TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'ZIP/postcode',textSize: 0.02),
                      TextContainer(
                        width: size?.wp(46),
                        color: theme.scaffoldBackgroundColor,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: zipController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: size?.hp(1),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'Country',textSize: 0.02),
                      Container(
                        height: size?.hp(6),
                        width: size?.wp(46),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        margin: EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                            color: theme.shadowColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: DropdownButton2<String>(
                          iconStyleData: IconStyleData(
                            iconDisabledColor: Color.fromRGBO(175, 175, 175, 1),
                            iconEnabledColor: Color.fromRGBO(175, 175, 175, 1),
                          ),
                          isExpanded: true,
                          underline: SizedBox(),
                          value: currencyNotifier.selectedCountry,
                          items: countries.map((Country country){
                            return DropdownMenuItem<String>(
                              value: country.name,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(country.flagImagePath,
                                    height: 12,
                                  ),
                                  SizedBox(width: 10),
                                  Text(country.name,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue){
                            setState(() {
                              currencyNotifier.selectedCountry=newValue!;
                              selectedCountry = newValue;
                              countryFlag = countries
                                  .firstWhere((country) => country.name == newValue)
                                  .flagImagePath;
                            });
                          },
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: AuthField(
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value.toString().contains(searchValue);
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'Mobile number',textSize: 0.02),
                      Container(
                        height: size?.hp(6),
                        width: size?.wp(46),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        margin: EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                            color: theme.shadowColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            DropdownButton<String>(
                              underline: SizedBox(),
                              elevation: 0,
                              value: selectedValue,
                              items: dropdownItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: numberController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: size?.hp(1),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'Land-phone number',textSize: 0.02),
                      TextContainer(
                        width: size?.wp(46),
                        color: theme.scaffoldBackgroundColor,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: landLineController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'UPI id',textSize: 0.02),
                      TextContainer(
                        width: size?.wp(46),
                          color: theme.scaffoldBackgroundColor,
                          child: Row(
                            children: [
                              SvgPicture.asset(upi,
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width:size?.wp(1)),
                              Expanded(
                                child: TextFormField(
                                  controller: upiController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: size?.hp(1),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HintText(text:(currencyNotifier.selectedCountry == 'India')?'GST number':'TRN number',textSize: 0.02),
                      TextContainer(
                        width: size?.wp(46),
                        color: theme.scaffoldBackgroundColor,
                        child: TextFormField(
                          controller: taxController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HintText(text: 'Accepting currency',textSize: 0.02),
                      Container(
                        width: size?.wp(46),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0,),
                          child: DropdownButton<String>(
                            icon: Container(
                              height: size?.hp(5),
                              width: size?.wp(6),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: SvgPicture.asset(add,color: theme.highlightColor,
                              ),
                            ),
                            underline: SizedBox(),
                            isExpanded: true,
                            elevation: 0,
                            hint: Text('Select accepting currency'),
                            value: selectedItem,
                            items: currencySymbol.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                  style: TextStyle(
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if (selectedItems.contains(newValue)) {
                                  selectedItems.remove(newValue);
                                } else {
                                  selectedItems.add(newValue!);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      if (selectedItems.isNotEmpty)
                        Container(
                          height: size?.hp(15),
                          child: ListView.builder(
                            itemCount: selectedItems.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(selectedItems[index]),
                                trailing: GestureDetector(
                                  child: Icon(Icons.visibility_outlined),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AuthButton(
                      text: 'Cancel',
                      action: () {
                      },
                      textColor: theme.primaryColor,
                      boxColor: theme.scaffoldBackgroundColor,
                      width: size!.wp(46),
                      textSize: 0.0325,
                    ),
                    AuthButton(
                      text: 'Save',
                      action: () {
                        // saveChanges();
                      },
                      textColor: theme.highlightColor,
                      boxColor: theme.primaryColor,
                      width: size!.wp(46),
                      textSize: 0.0325,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: theme.scaffoldBackgroundColor,
                                content: Container(
                                  height: size?.hp(17),
                                  child: Column(
                                    children: [
                                      Text("Are you sure you want to\ndelete your account? This\nwill cause all your data to",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('be ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400

                                            ),
                                          ),
                                          Text('permanently lost',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                color: theme.primaryColor
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('please ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            Text('confirm',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600, color: theme.primaryColor
                                              ),
                                            ),
                                            Text(' if you sure',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  AuthButton(text: 'Cancel',
                                      textSize: 0.035,
                                      action: (){
                                        Navigator.pop(context);
                                      },
                                      textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(29)),
                                  SizedBox(width: size?.wp(2),),
                                  AuthButton(text: 'Confirm', action: (){
                                  },
                                      textSize: 0.035,
                                      textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(29)),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Delete account',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromRGBO(18, 16, 246, 1),
                            color: Color.fromRGBO(18, 16, 246, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width * 0.0225,

                          ),
                        )),
                    SizedBox(width: size?.wp(3),),
                    TextButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                backgroundColor: theme.focusColor,
                                contentPadding: EdgeInsets.all(10),
                                content: Container(
                                  height: size?.hp(20),
                                  child: Column(
                                    children: [
                                      Text("Don't forget to remember",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('your ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          Text('email',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                color: theme.primaryColor
                                            ),
                                          ),
                                          Text(' and ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          Text('password',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                color: theme.primaryColor
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text('for your next login. Get\nback soon!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AuthButton(text: 'Cancel',
                                                textSize: 0.035,
                                                action: (){
                                                  Navigator.pop(context);
                                                },
                                                textColor: theme.primaryColor, boxColor: theme.focusColor, width: size!.wp(29)),
                                            SizedBox(width: size?.wp(4),),
                                            AuthButton(text: 'Confirm', action: (){},
                                                textSize: 0.035,
                                                textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(29)),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text('Logout account',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromRGBO(18, 16, 246, 1),
                            color: Color.fromRGBO(18, 16, 246, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width * 0.0225,
                          ),
                        )),
                  ],
                ),
              ),
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
