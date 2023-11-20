import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_pos/utils/images.dart';
import 'package:pocket_pos/utils/responsive.dart';
import 'package:pocket_pos/widgets/buttons/back_button.dart';
import 'package:pocket_pos/widgets/my_bottom.dart';
import 'package:pocket_pos/widgets/text/inter500.dart';
import 'package:pocket_pos/widgets/time_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../model/horiz_bar_model.dart';
import '../../../model/pie_data.dart';
import '../../../widgets/text/appBar_title.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  
  List<String> days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  int currentIndex = 0;
  int selectedSectionIndex = -1;
  Screen ? size;
  bool _hasfocus=true;
  bool _hasfocus2=false;
  bool _hasText=true;
  bool _hasText2=false;
  bool _hasDay= true;
  bool checkedItems = false;
  bool checkedItems2 = false;
  bool checkedItems3 = false;
  bool checkedItems4 = false;
  bool isToogle= false;
  bool _hasGst=true;
  bool _hasTax= false;
  String? selectedValue;
  String? selectedValue2;

  TextStyle custom(BuildContext context, double value) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: MediaQuery.of(context).size.width * 0.03,
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


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: PopButton(),
        title: AppBarTitle(text: 'Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text(''),
              leading: Inter500(text: 'Most active times'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _hasfocus=!_hasfocus;
                                  _hasText= !_hasText;
                                  _hasfocus2=false;
                                  _hasText2=false;
                                  _hasDay=true;
                                });
                                },
                              child: TimeContainer(
                                text: 'Hour',
                                boxColor: _hasfocus?theme.primaryColor:theme.focusColor,
                                textColor: _hasText?theme.highlightColor:theme.indicatorColor,
                              )
                          ),
                          SizedBox(width: size?.wp(3),),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _hasfocus2=!_hasfocus2;
                                  _hasText2= !_hasText2;
                                  _hasfocus=false;
                                  _hasText=false;
                                  _hasDay = false;
                                });
                                },
                              child: TimeContainer(
                                text: 'Days',
                                boxColor: _hasfocus2?theme.primaryColor:theme.focusColor,
                                textColor: _hasText2?theme.highlightColor:theme.indicatorColor,
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
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
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
                                      barRods: [BarChartRodData(y: 5, colors: [theme.primaryColor],width: size?.wp(10),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                      ),],),
                                      BarChartGroupData(x: 1,
                                        barRods: [BarChartRodData(y: 3, colors:[theme.primaryColor],width: size?.wp(10),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                        ),],),
                                      BarChartGroupData(x: 2,
                                        barRods: [BarChartRodData(y: 7, colors: [theme.primaryColor],width: size?.wp(10),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                        ),],),
                                      BarChartGroupData(x: 3,
                                        barRods: [BarChartRodData(y: 10, colors: [theme.primaryColor],width: size?.wp(10),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                        ),],),
                                      BarChartGroupData(x: 4,
                                        barRods: [BarChartRodData(y: 2, colors: [theme.primaryColor],width: size?.wp(10),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                        ),],),
                                      BarChartGroupData(x: 5,
                                        barRods: [BarChartRodData(y: 6, colors: [theme.primaryColor],width: size?.wp(10),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                        ),],),
                                      BarChartGroupData(x: 6,
                                        barRods: [BarChartRodData(y: 9, colors: [theme.primaryColor],width: size?.wp(10),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                        ),],),
                                      BarChartGroupData(x: 7,
                                        barRods: [BarChartRodData(y: 8, colors: [theme.primaryColor],width: size?.wp(10),
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
                                    barRods: [BarChartRodData(y: 5, colors: [theme.primaryColor],width: size?.wp(12),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                    ),],),
                                    BarChartGroupData(x: 1,
                                      barRods: [BarChartRodData(y: 3, colors:[theme.primaryColor],width: size?.wp(12),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                      ),],),
                                    BarChartGroupData(x: 2,
                                      barRods: [BarChartRodData(y: 7, colors: [theme.primaryColor],width: size?.wp(12),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                      ),],),
                                    BarChartGroupData(x: 3,
                                      barRods: [BarChartRodData(y: 10, colors: [theme.primaryColor],width: size?.wp(12),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                      ),],),
                                    BarChartGroupData(x: 4,
                                      barRods: [BarChartRodData(y: 2, colors: [theme.primaryColor],width: size?.wp(12),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                      ),],),
                                    BarChartGroupData(x: 5,
                                      barRods: [BarChartRodData(y: 6, colors: [theme.primaryColor],width: size?.wp(12),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                      ),],),
                                    BarChartGroupData(x: 6,
                                      barRods: [BarChartRodData(y: 9, colors: [theme.primaryColor],width: size?.wp(12),
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
            ),
    ExpansionTile(title: Text(''),
      leading: Inter500(text: 'Top 5 selling products',),
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
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
        )
      ],
    ),
    ExpansionTile(title: Text(''),
      leading: Inter500(text: 'Least 5 selling product'),
      children: [
        Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
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
                      spacing: 2,
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
              ),
            )
          ]
        )
      ],
    ),
    ExpansionTile(title: Text(''),
      leading: Inter500(text: 'TAX Reports'),
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
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
                              textColor: _hasGst?theme.highlightColor:theme.indicatorColor),
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
                              textColor: _hasTax?theme.highlightColor:theme.indicatorColor),
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
                    color: theme.primaryColor
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
    ExpansionTile(title: Text(''),
      leading: Inter500(text: 'Profit reports'),
      children: [
        Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    iconEnabledColor: theme.scaffoldBackgroundColor,
                    iconDisabledColor: theme.scaffoldBackgroundColor,
                    hint:Text('Export',style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor
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
              ),
              SizedBox(height: size?.hp(2),),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Inter500(text: 'Day wise report'),
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
      ],
    ),
    ExpansionTile(title: Text(''),
      leading: Inter500(text: 'Item wise report'),
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap:(){
                  _selectDate(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              ),
              SizedBox(height: size?.hp(2),),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(theme.primaryColor),
                    columns: [
                      DataColumn(label: TableHeader(text: 'Barcode',)),
                      DataColumn(label: TableHeader(text: 'Item name',)),
                      DataColumn(label: TableHeader(text: 'Item count')),
                      DataColumn(label: TableHeader(text: 'Cost')),
                      DataColumn(label: TableHeader(text: 'Price')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('112358')),
                        DataCell(Text('Biriyani')),
                        DataCell(Text('10')),
                        DataCell(Text('600')),
                        DataCell(Text('1000')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('427654')),
                        DataCell(Text('Beef Chilli')),
                        DataCell(Text('9')),
                        DataCell(Text('900')),
                        DataCell(Text('1350')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('292715')),
                        DataCell(Text('Fish')),
                        DataCell(Text('8')),
                        DataCell(Text('480')),
                        DataCell(Text('800')),
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
    ExpansionTile(title: Text(''),
      leading: Inter500(text: 'Collection distribution'),
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Total amount',
              style: TextStyle(
                  color: theme.indicatorColor,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400
              ),
            ),
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
                        isToogle=true;
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
                        isToogle=true;
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
                        isToogle=true;
                      });
                      },
                  ),
                  Text('Card 30%',
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
                        isToogle=true;
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
              Center(
                child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        height: '100%',
                        width: '100%',
                        widget: PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 0,
                          color: theme.scaffoldBackgroundColor,
                          child: Container(),
                        )),
                    CircularChartAnnotation(
                        widget:  Text('40%',
                            style: TextStyle(
                                color: theme.indicatorColor, fontSize: 25)))],
                              series: <DoughnutSeries<PieData, String>>[DoughnutSeries<PieData, String>(
                                  dataSource: <PieData>[
                                    PieData('Cash', 40,theme.primaryColor),
                                    PieData('Google py', 20,theme.primaryColor),
                                    PieData('Card', 5,theme.primaryColor),
                                    PieData('Credit', 25,theme.primaryColor)
                                  ],
                                  xValueMapper: (PieData data, _) => data.label,
                  yValueMapper: (PieData data, _) => data.value,
                  pointColorMapper: (PieData data, _) => data.color,
                  innerRadius: '70',
                  explode:  isToogle,
                  initialSelectedDataIndexes: const [0,1,2,3],
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  ),
                )
                    ]
              )
                )
                ],
              ),
        ),
      ],
    ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(
        hasFocus: false,homeSelect: false,
        hasFocus2: true,reportSelect: true,
        hasFocus3: false,scannerSelect: false,
        hasFocus4: false,profile: false,
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  late String text;
  TableHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(text,
    style: TextStyle(
      fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    color: theme.highlightColor
    ),
    );
  }
}
