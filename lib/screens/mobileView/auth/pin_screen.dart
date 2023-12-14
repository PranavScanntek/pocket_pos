import 'package:flutter/material.dart';

import 'package:pocket_pos/utils/responsive.dart';

import '../dash/home/home_screen.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  Screen ? size;
  String _correctPin = "1234";
  FocusNode? _focusNode;
  List<TextEditingController> _otpControllers = List.generate(
    4,
        (index) => TextEditingController(),
  );
  List<bool> _boxSelected = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    Future.delayed(Duration.zero, () => FocusScope.of(context).requestFocus(_focusNode));
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(_onOTPChanged(i));
    }
  }
  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  void Function() _onOTPChanged(int index) {
    return () {
      setState(() {
        _boxSelected[index] = _otpControllers[index].text.isNotEmpty;
      });
      if (_otpControllers[index].text.isNotEmpty && index < _otpControllers.length - 1) {
        FocusScope.of(context).nextFocus();
      }
    };
  }

  bool allBoxesFilled() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _checkPinAndNavigate(String enteredPin) {
    if (enteredPin == _correctPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(41, 41, 41, 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the Pin',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                color: theme.indicatorColor
              ),
            ),
            Text('We are automatically detect your\nemployee type',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: theme.hintColor
              ),
            ),
    SizedBox(height: size?.hp(2),),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    List.generate(
    4,
    (index) => Container(
      alignment: Alignment.center,
      width: size?.wp(16),
      height: size?.hp(9),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _boxSelected[index] ? theme.primaryColor: Color.fromRGBO(114, 112, 112, 0.25),
      ),
      child: TextField(
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
    String enteredPin = _otpControllers.map((controller) => controller.text).join();
    _checkPinAndNavigate(enteredPin);
          }
        },
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: MediaQuery.of(context).size.width * 0.05,
          fontWeight: FontWeight.w600,
          color: theme.highlightColor,
        ),
      ),
    ),
    )
    )
          ],
        ),
      ),
    );
  }
}
