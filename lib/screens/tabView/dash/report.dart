import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_pos/screens/tabView/dash/home/tab_bag_screen.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../helper/provider_helper/product_provider.dart';
import '../../../model/horiz_bar_model.dart';
import '../../../utils/images.dart';
import '../../../widgets/buttons/bag_button.dart';
import '../../../widgets/buttons/theme_button.dart';
import '../../../widgets/tabBottomNavi.dart';
import '../../../widgets/tab_drawer.dart';
import '../../../widgets/time_container.dart';
import '../../mobileView/dash/report/report_screen.dart';

class TabReport extends StatefulWidget {
  const TabReport({super.key});

  @override
  State<TabReport> createState() => _TabReportState();
}

class _TabReportState extends State<TabReport> {
  Screen ? size;
  bool checkedItems = false;
  bool checkedItems2 = false;
  bool checkedItems3 = false;
  bool checkedItems4 = false;
  bool hasCash=true;
  bool hasGpay=false;
  bool hasCredit= false;
  bool hasCreditCard= false;
  int touchedIndex =-1;
  bool _hasfocus=true;
  bool _hasfocus2=false;
  bool _hasDay= true;
  int currentIndex = 0;
  String? selectedValue;
  String? selectedValue2;
  bool _hasGst=true;
  bool _hasTax= false;
  List<String> days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        builder: (context ,child){
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Color.fromRGBO(255, 61, 143, 1),
                ),
                dialogBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: child!);
        }
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextStyle custom(BuildContext context, double value) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: MediaQuery.of(context).size.width * 0.0175,
    );
  }

  void incrementIndex() {
    setState(() {
      currentIndex = (currentIndex + 1) % days.length;
    });
  }

  void decrementIndex() {
    setState(() {
      currentIndex = (currentIndex - 1 + days.length) % days.length;
    });
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: size?.wp(53),
                          decoration: BoxDecoration(
                            color:theme.scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color:theme.shadowColor,
                                spreadRadius:2,
                                blurRadius: 10,
                                offset: Offset(-2, -2)
                              )
                            ],
                            borderRadius:BorderRadius.circular(12)
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height:size?.hp(40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text('Collection distribution',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: MediaQuery.of(context).size.width * 0.0225,
                                        color: theme.indicatorColor
                                    ),
                                    ),
                                  ),
                                    Text('Total amount',
                                      style: TextStyle(
                                          color: theme.indicatorColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    Row(
                                      children: [
                                        Text('365.56',
                                          style: TextStyle(
                                              color: theme.indicatorColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        Text('AED',
                                          style: TextStyle(
                                              color: theme.indicatorColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          activeColor: theme.indicatorColor,
                                          checkColor: theme.indicatorColor,
                                          value: checkedItems,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkedItems = value!;
                                              checkedItems=true;
                                              checkedItems2=false;
                                              checkedItems3=false;
                                              checkedItems4=false;
                                            });
                                          },
                                        ),
                                        Text('Cash 40%',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              color: theme.indicatorColor
                                          ),
                                        ),
                                        Checkbox(
                                          activeColor: theme.indicatorColor,
                                          checkColor: theme.indicatorColor,
                                          value: checkedItems2,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkedItems2 = value!;
                                              checkedItems=false;
                                              checkedItems2=true;
                                              checkedItems3=false;
                                              checkedItems4=false;
                                            });
                                          },
                                        ),
                                        Text('Google pay 25%',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              color: theme.indicatorColor
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          activeColor: theme.indicatorColor,
                                          checkColor: theme.indicatorColor,
                                          value: checkedItems3,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkedItems3 = value!;
                                              checkedItems=false;
                                              checkedItems2=false;
                                              checkedItems3=true;
                                              checkedItems4=false;
                                            });
                                          },
                                        ),
                                        Text('Card 20%',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              color: theme.indicatorColor
                                          ),
                                        ),
                                        Checkbox(
                                          activeColor: theme.indicatorColor,
                                          checkColor: theme.indicatorColor,
                                          value: checkedItems4,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkedItems4 = value!;
                                              checkedItems=false;
                                              checkedItems2=false;
                                              checkedItems3=false;
                                              checkedItems4=true;
                                            });
                                          },
                                        ),
                                        Text('Credit 15%',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              color: theme.indicatorColor
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        if(checkedItems==true)
                                          Text('Cash\n40 AED',
                                            textAlign: TextAlign.center,
                                          ),
                                        if(checkedItems2==true)
                                          Text('GooglePay\n25 AED',
                                            textAlign: TextAlign.center,
                                          ),
                                        if(checkedItems3==true)
                                          Text('Credit Card\n20 AED',
                                            textAlign: TextAlign.center,
                                          ),
                                        if(checkedItems4==true)
                                          Text('Credit\n15 AED',
                                            textAlign: TextAlign.center,
                                          ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          alignment: Alignment.topCenter,
                                          height: size?.hp(40),
                                          child: PieChart(
                                              swapAnimationCurve: Curves.easeInExpo,
                                              swapAnimationDuration: Duration(milliseconds: 750),
                                              PieChartData(
                                                  pieTouchData: PieTouchData(
                                                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                                      setState(() {
                                                        if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                                          touchedIndex = -1;
                                                          return;
                                                        }
                                                        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                                      });
                                                    },
                                                  ),
                                                  sectionsSpace: 10,
                                                  sections: [
                                                    PieChartSectionData(
                                                        radius: 50,
                                                        value: 40,
                                                        title:'40%',
                                                        titleStyle: TextStyle(color: theme.highlightColor),
                                                        color:checkedItems?theme.primaryColor:Color.fromRGBO(255, 43, 133, 0.25)

                                                    ),
                                                    PieChartSectionData(
                                                        radius: 50,
                                                        value: 25,
                                                        title:'25%',
                                                        titleStyle: TextStyle(color: theme.highlightColor),
                                                        color: checkedItems2?theme.primaryColor:Color.fromRGBO(255, 43, 133, 0.25)
                                                    ),
                                                    PieChartSectionData(
                                                        radius: 50,
                                                        value: 20,
                                                        title:'20%',
                                                        titleStyle: TextStyle(color: theme.highlightColor),
                                                        color: checkedItems3?theme.primaryColor:Color.fromRGBO(255, 43, 133, 0.25)
                                                    ),
                                                    PieChartSectionData(
                                                        radius: 50,
                                                        value: 15,
                                                        title:'15%',
                                                        titleStyle: TextStyle(color: theme.highlightColor),
                                                        color: checkedItems4?theme.primaryColor:Color.fromRGBO(255, 43, 133, 0.25)
                                                    ),
                                                  ]
                                              )
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size?.wp(53),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  _selectDate(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Item wise report',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context).size.width * 0.0225,
                                          color: theme.indicatorColor
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text("${selectedDate.toLocal()}".split(' ')[0],
                                          style: TextStyle(
                                              color: theme.primaryColor,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Icon(Icons.keyboard_arrow_down,color: theme.primaryColor,)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size?.hp(2),),
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    headingRowColor: MaterialStateProperty.all(theme.primaryColor),
                                    columns: [
                                      DataColumn(label: TableHeader(text: 'Serial No',)),
                                      DataColumn(label: TableHeader(text: 'Item name',)),
                                      DataColumn(label: TableHeader(text: 'Quantity ')),
                                      DataColumn(label: TableHeader(text: 'Amount')),
                                      DataColumn(label: TableHeader(text: 'Total')),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text('112358')),
                                        DataCell(Text('Biriyani')),
                                        DataCell(Text('10')),
                                        DataCell(Text('130')),
                                        DataCell(Text('1300')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('427654')),
                                        DataCell(Text('Beef Chilli')),
                                        DataCell(Text('9')),
                                        DataCell(Text('90')),
                                        DataCell(Text('810')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('292715')),
                                        DataCell(Text('Fish')),
                                        DataCell(Text('8')),
                                        DataCell(Text('70')),
                                        DataCell(Text('560')),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size?.wp(43),
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                            maxHeight: size!.hp(50),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap:() {
                                        setState(() {
                                          hasCash = !hasCash;hasGpay = false;hasCreditCard=false;hasCredit=false;
                                        });
                                      },
                                      child: TimeContainer(text: 'Cash', boxColor: hasCash?theme.primaryColor:theme.focusColor, textColor: hasCash?theme.highlightColor:theme.indicatorColor,textSize: 0.0150)),
                                  SizedBox(width: size?.wp(1),),
                                  InkWell(
                                      onTap:() {
                                        setState(() {
                                          hasGpay = !hasGpay;hasCash = false;hasCreditCard=false;hasCredit=false;
                                        });
                                      },
                                      child: TimeContainer(text: 'Google pay', boxColor: hasGpay?theme.primaryColor:theme.focusColor, textColor: hasGpay?theme.highlightColor:theme.indicatorColor,textSize: 0.0150)),
                                  SizedBox(width: size?.wp(1),),
                                  InkWell(
                                      onTap:() {
                                        setState(() {
                                          hasCreditCard = !hasCreditCard;hasCash = false;hasGpay=false;hasCredit=false;
                                        });
                                      },
                                      child: TimeContainer(text: 'Credit card', boxColor: hasCreditCard?theme.primaryColor:theme.focusColor, textColor: hasCreditCard?theme.highlightColor:theme.indicatorColor,textSize: 0.0150)),
                                  SizedBox(width: size?.wp(1),),
                                  InkWell(
                                      onTap:() {
                                        setState(() {
                                          hasCredit = !hasCredit;hasCash = false;hasGpay=false;hasCreditCard=false;
                                        });
                                      },
                                      child: TimeContainer(text: 'Credit', boxColor: hasCredit?theme.primaryColor:theme.focusColor, textColor: hasCredit?theme.highlightColor:theme.indicatorColor,textSize: 0.0150)),
                                ],
                              ),
                              SizedBox(height: size?.hp(2),),
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    headingRowColor: MaterialStateProperty.all(theme.primaryColor,),
                                    columns: [
                                      DataColumn(label: TableHeader(text: 'Serial No',)),
                                      DataColumn(label: TableHeader(text: 'Invoice No',)),
                                      DataColumn(label: TableHeader(text: 'Amount')),],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text('112358')),
                                        DataCell(Text('36729641053')),
                                        DataCell(Text('500')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('112359')),
                                        DataCell(Text('36729641043')),
                                        DataCell(Text('260')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('112458')),
                                        DataCell(Text('36729642053')),
                                        DataCell(Text('300')),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
                          width: size?.wp(43),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Most active times',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.of(context).size.width * 0.0225,
                                    color: theme.indicatorColor
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          _hasfocus=!_hasfocus;
                                          _hasfocus2=false;
                                          _hasDay=true;
                                        });
                                      },
                                      child: TimeContainer(
                                          text: 'Hour',
                                          boxColor: _hasfocus?theme.primaryColor:theme.focusColor,
                                          textColor: _hasfocus?theme.highlightColor:theme.indicatorColor,
                                          textSize: 0.02
                                      )
                                  ),
                                  SizedBox(width: size?.wp(3),),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          _hasfocus2=!_hasfocus2;
                                          _hasfocus=false;
                                          _hasDay = false;
                                        });
                                      },
                                      child: TimeContainer(
                                          text: 'Days',
                                          boxColor: _hasfocus2?theme.primaryColor:theme.focusColor,
                                          textColor: _hasfocus2?theme.highlightColor:theme.indicatorColor,
                                          textSize: 0.02
                                      )
                                  ),
                                ],
                              ),
                              if(_hasDay)
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: SvgPicture.asset(backIos,color: theme.indicatorColor,),
                                        onPressed: decrementIndex,
                                      ),
                                      SizedBox(width: 10),
                                      Text(days[currentIndex],
                                        style: TextStyle(
                                          color: theme.indicatorColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery.of(context).size.width * 0.02,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        icon: SvgPicture.asset(forwardIos,color: theme.indicatorColor,),
                                        onPressed: incrementIndex,
                                      ),
                                    ],
                                  ),
                                ),
                              if(_hasfocus)
                                Container(
                                  width: double.infinity,
                                  height: size?.hp(25),
                                  child: BarChart(BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      gridData: FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                      barGroups:[BarChartGroupData(x: 0,
                                        barRods: [BarChartRodData(y: 5, colors: [theme.primaryColor],width: size?.wp(4),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                        ),],),
                                        BarChartGroupData(x: 1,
                                          barRods: [BarChartRodData(y: 3, colors:[theme.primaryColor],width: size?.wp(4),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 2,
                                          barRods: [BarChartRodData(y: 7, colors: [theme.primaryColor],width: size?.wp(4),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 3,
                                          barRods: [BarChartRodData(y: 10, colors: [theme.primaryColor],width: size?.wp(4),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 4,
                                          barRods: [BarChartRodData(y: 2, colors: [theme.primaryColor],width: size?.wp(4),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 5,
                                          barRods: [BarChartRodData(y: 6, colors: [theme.primaryColor],width: size?.wp(4),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 6,
                                          barRods: [BarChartRodData(y: 9, colors: [theme.primaryColor],width: size?.wp(4),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          ),],),
                                        BarChartGroupData(x: 7,
                                          barRods: [BarChartRodData(y: 8, colors: [theme.primaryColor],width: size?.wp(4),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          ),],),
                                      ],
                                      titlesData: FlTitlesData(
                                          show: true,
                                          topTitles: SideTitles(showTitles: false),
                                          leftTitles: SideTitles(showTitles: false),
                                          rightTitles: SideTitles(showTitles: false),
                                          bottomTitles: SideTitles(
                                              showTitles: true,
                                              getTitles: (value){
                                                switch (value.toInt()) {
                                                  case 0:
                                                    return '12a';
                                                  case 1:
                                                    return '3a';
                                                  case 2:
                                                    return '6a';
                                                  case 3:
                                                    return '9a';
                                                  case 4:
                                                    return '12p';
                                                  case 5:
                                                    return '3p';
                                                  case 6:
                                                    return '6p';
                                                  case 7:
                                                    return '9p';
                                                  default:
                                                    return '';
                                                }
                                              },
                                              getTextStyles:custom
                                          )
                                      )
                                  )
                                  ),
                                ),
                              if(_hasfocus2)
                                Container(
                                  width: double.infinity,
                                  height: size?.hp(25),
                                  child: BarChart(BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      gridData: FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                      barGroups:[BarChartGroupData(x: 0,
                                        barRods: [BarChartRodData(y: 5, colors: [theme.primaryColor],width: size?.wp(5),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                        ),],),
                                        BarChartGroupData(x: 1,
                                          barRods: [BarChartRodData(y: 3, colors:[theme.primaryColor],width: size?.wp(5),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 2,
                                          barRods: [BarChartRodData(y: 7, colors: [theme.primaryColor],width: size?.wp(5),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 3,
                                          barRods: [BarChartRodData(y: 10, colors: [theme.primaryColor],width: size?.wp(5),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 4,
                                          barRods: [BarChartRodData(y: 2, colors: [theme.primaryColor],width: size?.wp(5),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 5,
                                          barRods: [BarChartRodData(y: 6, colors: [theme.primaryColor],width: size?.wp(5),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),],),
                                        BarChartGroupData(x: 6,
                                          barRods: [BarChartRodData(y: 9, colors: [theme.primaryColor],width: size?.wp(5),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          ),],),],
                                      titlesData: FlTitlesData(
                                          show: true,
                                          topTitles: SideTitles(showTitles: false),
                                          leftTitles: SideTitles(showTitles: false),
                                          rightTitles: SideTitles(showTitles: false),
                                          bottomTitles: SideTitles(
                                              showTitles: true,
                                              getTitles: (value){
                                                switch (value.toInt()) {
                                                  case 0:
                                                    return 'Sun';
                                                  case 1:
                                                    return 'Mon';
                                                  case 2:
                                                    return 'Tue';
                                                  case 3:
                                                    return 'Wed';
                                                  case 4:
                                                    return 'Thu';
                                                  case 5:
                                                    return 'Fri';
                                                  case 6:
                                                    return 'Sat';
                                                  default:
                                                    return '';
                                                }
                                              },
                                              getTextStyles:custom
                                          )
                                      )
                                  )
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: size?.wp(48),
                          decoration: BoxDecoration(
                              color:theme.scaffoldBackgroundColor,
                              boxShadow: [
                                BoxShadow(
                                    color:theme.shadowColor,
                                    spreadRadius:2,
                                    blurRadius: 10,
                                    offset: Offset(-2, -2)
                                )
                              ],
                              borderRadius:BorderRadius.circular(12)
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:20),
                                child: Text('Top 5 selling products',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.width * 0.0225,
                                      color: theme.indicatorColor
                                  ),
                                ),
                              ),
                              Center(
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    borderWidth: 0,
                                    borderColor: Colors.transparent,
                                    majorGridLines: MajorGridLines(width: 0),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    isVisible: false,
                                    borderWidth: 0,
                                    borderColor: Colors.transparent,
                                    majorGridLines: MajorGridLines(width: 0,), // Hide major gridlines
                                  ),
                                  series: <BarSeries<ChartData, String>>[
                                    BarSeries<ChartData, String>(
                                      spacing: 1.5,
                                        color: theme.primaryColor,
                                        isVisible: true,
                                        dataSource: <ChartData>[
                                          ChartData('Category A', 13),
                                          ChartData('Category B', 15),
                                          ChartData('Category C', 17),
                                          ChartData('Category D', 20),
                                          ChartData('Category E', 35)
                                        ],
                                        xValueMapper: (ChartData data, _) => data.category,
                                        yValueMapper: (ChartData data, _) => data.value,
                                        borderWidth: 0,
                                        borderColor: Colors.transparent,
                                        dataLabelSettings: DataLabelSettings(
                                            isVisible: false
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size?.wp(48),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:20,),
                                child: Text('Tax report',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery.of(context).size.width * 0.0225,
                                      color: theme.indicatorColor
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:20),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                _hasGst=!_hasGst;
                                                _hasTax=false;
                                              });
                                            },
                                            child: TimeContainer(
                                                text: 'GST',
                                                boxColor: _hasGst?theme.primaryColor:theme.focusColor,
                                                textColor: _hasGst?theme.highlightColor:theme.indicatorColor,textSize: 0.02),
                                          ),
                                          SizedBox(width: size?.wp(3),),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                _hasTax=!_hasTax;
                                                _hasGst=false;
                                              });
                                            },
                                            child: TimeContainer(
                                                text: 'Vat',
                                                boxColor: _hasTax?theme.primaryColor:theme.focusColor,
                                                textColor: _hasTax?theme.highlightColor:theme.indicatorColor,textSize: 0.02),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        iconEnabledColor: theme.scaffoldBackgroundColor,
                                        iconDisabledColor: theme.scaffoldBackgroundColor,
                                        hint:Text('Export',style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            color: theme.primaryColor,
                                          fontSize: MediaQuery.of(context).size.width * 0.02,
                                        ),), // Hint text
                                        value: selectedValue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedValue = newValue;
                                          });
                                        },
                                        items: [
                                          'PDF',
                                          'EXCEL',
                                        ].map<DropdownMenuItem<String>>((String? value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value ?? 'export',),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size?.hp(2),),
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    headingRowColor: MaterialStateProperty.all(theme.primaryColor),
                                    columns: [
                                      DataColumn(label: TableHeader(text: 'Serial No',)),
                                      DataColumn(label: GestureDetector(
                                        onTap: (){
                                          _selectDate(context);
                                        },
                                        child: Row(
                                          children: [
                                            TableHeader(text: 'Date'),
                                            SizedBox(width: size?.wp(3),),
                                            Icon(Icons.keyboard_arrow_down_outlined,color: theme.highlightColor,)
                                          ],
                                        ),
                                      )),
                                      DataColumn(label: TableHeader(text: 'Invoice No',)),
                                      DataColumn(label: TableHeader(text: 'Total amount',)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text('527653')),
                                        DataCell(Text('09/08/2023')),
                                        DataCell(Text('46296269826')),
                                        DataCell(Text('500')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('527654')),
                                        DataCell(Text('09/08/2023')),
                                        DataCell(Text('46296269828')),
                                        DataCell(Text('200')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('527655')),
                                        DataCell(Text('09/08/2023')),
                                        DataCell(Text('46296269827')),
                                        DataCell(Text('700')),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: size?.wp(48),
                            decoration: BoxDecoration(
                                color:theme.scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color:theme.shadowColor,
                                      spreadRadius:2,
                                      blurRadius: 10,
                                      offset: Offset(-2, -2)
                                  )
                                ],
                                borderRadius:BorderRadius.circular(12)
                            ),
                            padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:20),
                                  child: Text('Least 5 selling products',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: MediaQuery.of(context).size.width * 0.0225,
                                        color: theme.indicatorColor
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SfCartesianChart(
                                    primaryXAxis: CategoryAxis(
                                      borderWidth: 0,
                                      borderColor: Colors.transparent,
                                      majorGridLines: MajorGridLines(width: 0),
                                    ),
                                    primaryYAxis: NumericAxis(
                                      isVisible: false,
                                      borderWidth: 0,
                                      borderColor: Colors.transparent,
                                      majorGridLines: MajorGridLines(width: 0,), // Hide major gridlines
                                    ),
                                    series: <BarSeries<ChartData, String>>[
                                      BarSeries<ChartData, String>(
                                        color: theme.primaryColor,
                                        spacing: 1.5,
                                        dataSource: <ChartData>[
                                          ChartData('Category E', 35),
                                          ChartData('Category D', 20),
                                          ChartData('Category C', 17),
                                          ChartData('Category B', 14),
                                          ChartData('Category A', 13)
                                        ],
                                        xValueMapper: (ChartData data, _) => data.category,
                                        yValueMapper: (ChartData data, _) => data.value,
                                        trackBorderWidth: 0,
                                      ),
                                    ],
                                  ),
                                )
                              ]
                          )
                        ),
                        Container(
                          width: size?.wp(48),
                            decoration: BoxDecoration(
                                color:theme.scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color:theme.shadowColor,
                                      spreadRadius:2,
                                      blurRadius: 10,
                                      offset: Offset(-2, -2)
                                  )
                                ],
                                borderRadius:BorderRadius.circular(12)
                            ),
                            padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:20),
                                    child: Text('Profit',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context).size.width * 0.0225,
                                          color: theme.indicatorColor
                                      ),
                                    ),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      iconEnabledColor: theme.scaffoldBackgroundColor,
                                      iconDisabledColor: theme.scaffoldBackgroundColor,
                                      hint:Text('Export',style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          color: theme.primaryColor,
                                        fontSize: MediaQuery.of(context).size.width * 0.02,

                                      ),), // Hint text
                                      value: selectedValue2,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValue2 = newValue;
                                        });
                                      },
                                      items: [
                                        'PDF',
                                        'EXCEL',
                                      ].map<DropdownMenuItem<String>>((String? value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value ?? 'export',),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size?.hp(2),),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Day wise report',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context).size.width * 0.0175,
                                          color: theme.indicatorColor
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                            width:15,
                                            height: 14,
                                            decoration: BoxDecoration(
                                                color: theme.primaryColor,
                                                borderRadius: BorderRadius.circular(2)
                                            ),
                                          ),
                                          Text('profit',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                color: theme.indicatorColor
                                            ),
                                          ),
                                          SizedBox(width: size?.wp(3),),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                            width:15,
                                            height: 14,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(11, 153, 255, 1),
                                                borderRadius: BorderRadius.circular(2)
                                            ),
                                          ),
                                          Text('expense',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                color: theme.indicatorColor
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 20,bottom: 20,right: 20),
                                  width: double.infinity,
                                  height: size?.hp(30),
                                  child: LineChart(LineChartData(
                                      gridData: FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                      lineBarsData:[
                                        LineChartBarData(
                                          spots: [
                                            FlSpot(1, 1000),
                                            FlSpot(2, 4000),
                                            FlSpot(3, 7000),
                                            FlSpot(4, 2000),
                                            FlSpot(5, 6000),
                                            FlSpot(6, 9000),
                                            FlSpot(7, 3000),
                                            FlSpot(8, 9500),
                                            FlSpot(9, 5000),
                                            FlSpot(10, 8000)
                                          ],
                                          isCurved: true,
                                          colors: [Color.fromRGBO(11, 153, 255, 1)],
                                          dotData: FlDotData(show: false),
                                          belowBarData: BarAreaData(show: false),
                                        ),
                                        LineChartBarData(
                                          spots: [
                                            FlSpot(1, 1750),
                                            FlSpot(2, 4040),
                                            FlSpot(3, 7100),
                                            FlSpot(4, 2650),
                                            FlSpot(5, 6111),
                                            FlSpot(6, 9019),
                                            FlSpot(7, 3110),
                                            FlSpot(8, 10000),
                                            FlSpot(9, 5053),
                                            FlSpot(10, 8150)
                                          ],
                                          isCurved: true,
                                          colors: [theme.primaryColor],
                                          dotData: FlDotData(show: false),
                                          belowBarData: BarAreaData(show: false),
                                        ),
                                      ],
                                      titlesData: FlTitlesData(
                                          rightTitles: SideTitles(showTitles: false),
                                          topTitles: SideTitles(showTitles: false)
                                      )
                                  ),
                                  )
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ]
        ),
      ),
      bottomNavigationBar: TabBottomNavi(
        hasFocus: false,
        hasFocus2: true,
        hasFocus3: false,
      ),
    );
  }
}
