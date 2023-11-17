import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pos/screens/dash/profile/profile_screen.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/appBar_title.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/provider_helper/currency_provider.dart';
import '../../../model/country_model.dart';
import '../../../utils/images.dart';
import '../../../widgets/authButton.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/my_bottom.dart';
import '../../../widgets/textWidgets.dart';
import '../../../widgets/text_container.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {

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
  String selectedCountry='Select a country';
  String countryFlag= blank;
  List<String> selectedItems = [];
  String? selectedItem;

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      selectedCountry= prefs.getString('country')?? '';
      countryFlag = prefs.getString('flag')??'';
      addressController.text = prefs.getString('address') ?? '';
      cityController.text = prefs.getString('city') ?? '';
      zipController.text = prefs.getString('zip') ?? '';
      numberController.text = prefs.getString('upi') ?? '';
      upiController.text = prefs.getString('number') ?? '';
      taxController.text = prefs.getString('gst') ?? '';
    });
  }

  void saveChanges() async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String address = addressController.text;
    final String city = cityController.text;
    final String zip = zipController.text;
    final String number = numberController.text;
    final String upi = upiController.text;
    final String gst = taxController.text;
    final String country = selectedCountry;
    final String flag = countryFlag;

    if (name.isNotEmpty && password.isNotEmpty && email.isNotEmpty && address.isNotEmpty && city.isNotEmpty && country.isNotEmpty &&
        zip.isNotEmpty && number.isNotEmpty && upi.isNotEmpty && gst.isNotEmpty && flag.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', nameController.text);
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setString('country', country);
      prefs.setString('flag', flag);
      prefs.setString('address', address);
      prefs.setString('city', city);
      prefs.setString('zip', zip);
      prefs.setString('upi', upi);
      prefs.setString('number', number);
      prefs.setString('gst', gst);
      Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___)=>Profile_screen()));
    }
    else {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Please  fill all fields'),
    ),
    );
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void toggleVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }
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

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('image', pickedFile.path);
    }
  }


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    var currencyNotifier = Provider.of<CountryNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 41, 41, 0.03),
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Profile settings'),
      ),
      body: SingleChildScrollView(
              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Center(
                child: Container(
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
                radius: 60,
                backgroundImage: FileImage(
                _imageFile!,
                ),
                ):
                CircleAvatar(
                radius: 60,
                backgroundColor: Color.fromRGBO(255, 43, 133, 0.19),
                child: Text('Add photo',
                style: TextStyle(
                color: theme.primaryColor,
                fontFamily: 'Inter'
                ),
                ),
                ),
                ),
                ),
                ),
                SizedBox(height: size?.hp(1),),
                HintText(text: 'Business name'),
                TextContainer(
                color: theme.scaffoldBackgroundColor,
                child: TextFormField(
                  controller: nameController,
                decoration: InputDecoration(
                border: InputBorder.none,
                ),
                ),
                ),
                SizedBox(height: size?.hp(1),),
                HintText(text: 'Email ID'),
                TextContainer(
                color: theme.scaffoldBackgroundColor,
                child: TextFormField(
                  controller: emailController,
                decoration: InputDecoration(
                border: InputBorder.none,
                ),
                ),
                ),
                SizedBox(height: size?.hp(1),),
                HintText(text: 'Password'),
                TextContainer(
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
                SizedBox(height: size?.hp(1),),
                HintText(text: 'Address'),
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
                HintText(text: 'City'),
                TextContainer(
                  width: size?.wp(43),
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
                HintText(text: 'ZIP/postcode'),
                TextContainer(
                  width: size?.wp(43),
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
                HintText(text: 'Country'),
                Container(
                  height: size?.hp(6),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                color: theme.shadowColor,
                borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton(
                iconDisabledColor: Color.fromRGBO(175, 175, 175, 1),
                iconEnabledColor: Color.fromRGBO(175, 175, 175, 1),
                isExpanded: true,
                underline: SizedBox(),
                elevation: 0,
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
                }
                ),
                ),
                SizedBox(height: size?.hp(1),),
                HintText(text: 'Mobile number'),
                Container(
                  height: size?.hp(6),
                width: double.infinity,
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
                  SizedBox(height: size?.hp(1),),
                  HintText(text: 'Land-phone number'),
                  TextContainer(
                    color: theme.scaffoldBackgroundColor,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: addressController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                SizedBox(height: size?.hp(1),),
                HintText(text: 'UPI id'),
                TextContainer(
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
                SizedBox(height: size?.hp(1),),
                HintText(text:(currencyNotifier.selectedCountry == 'India')?'GST number':'TRN number'),
                TextContainer(
                color: theme.scaffoldBackgroundColor,
                child: TextFormField(
                  controller: taxController,
                decoration: InputDecoration(
                border: InputBorder.none,
                ),
                ),
                ),
                SizedBox(height: size?.hp(1),),
                HintText(text: 'Accepting currency'),
                Padding(
                padding: const EdgeInsets.only(left: 20.0,),
                child: DropdownButton<String>(
                icon: Container(
                width: size?.wp(7),
                height: size?.hp(4),
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
                  width: size!.wp(43),
                  ),
                  AuthButton(
                  text: 'Save',
                  action: () {
                    saveChanges();
                  },
                  textColor: theme.highlightColor,
                  boxColor: theme.primaryColor,
                  width: size!.wp(43),
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
                action: (){
                Navigator.pop(context);
                },
                textColor: theme.primaryColor, boxColor: theme.scaffoldBackgroundColor, width: size!.wp(29)),
                SizedBox(width: size?.wp(2),),
                AuthButton(text: 'Confirm', action: (){
                },
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

                ),
                )),
                SizedBox(width: size?.wp(3),),
                TextButton(
                onPressed: (){
                showDialog(
                context: context,
                builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: theme.focusColor,
                content: Container(
                height: size?.hp(12),
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
                ],
                ),
                ),
                actions: [
                AuthButton(text: 'Cancel',
                action: (){
                Navigator.pop(context);
                },
                textColor: theme.primaryColor, boxColor: theme.focusColor, width: size!.wp(29)),
                SizedBox(width: size?.wp(3),),
                AuthButton(text: 'Confirm', action: (){},
                textColor: theme.highlightColor, boxColor: theme.primaryColor, width: size!.wp(29)),
                ],
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

                ),
                )),
                ],
                ),
                ),
                ],
                ),
              ),
    ),
        bottomNavigationBar:MyBottomBar(
          hasFocus: false,homeSelect: false,
          hasFocus2: false,reportSelect: false,
          hasFocus3: false,scannerSelect: false,
          hasFocus4: false,profile: false,
        )
    );
  }
}
