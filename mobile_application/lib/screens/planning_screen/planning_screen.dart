import 'package:flutter/material.dart';
import 'package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart';
import 'package:mobile_application/screens/shared_for_screens/navigation_buttons.dart';
import 'package:mobile_application/screens/shared_for_screens/screen_enum.dart';
import 'package:mobile_application/shared/styled_text.dart';
import 'package:mobile_application/theme.dart';

const List<String> weekDayNames = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"] ; 

enum SubScreen {
  calendar, 
  persones
}

class WeekDay extends StatelessWidget {
  const WeekDay({
    required this.name, 
    super.key
  });

  final String name ; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin : EdgeInsetsGeometry.symmetric(horizontal : 15, vertical : 5), 
      child: Card(
        color : AppColors.secondaryAccentColor,   
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        child : ExpansionTile(
          title : StyledTitle(name), 
          trailing : Icon(Icons.expand_more), 
          expandedCrossAxisAlignment : CrossAxisAlignment.end,
          children : [
            for (String time in ["Morgen", "Mittag", "Abend"])
              Container(
                margin : EdgeInsetsGeometry.only(left : 20), 
                child: Row(
                  children : [
                    StyledHeading("$time: "), 
                    StyledText("Menü")
                  ]
                ),
              )
          ]
        ) 
      ),
    ) ;   
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  SubScreen _subScreens = SubScreen.calendar ; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menüplan"),
        actions: [
          NavigationBarButtonWrapper(
            isChoosen: _subScreens == SubScreen.calendar ? true : false,
            child: NavigationBarButton(
              icon: Icon(Icons.calendar_today),
              actionFunc: () {
                setState(() {_subScreens = SubScreen.calendar ; }) ; 
              },
            ),
          ),
          NavigationBarButtonWrapper(
            isChoosen: _subScreens == SubScreen.persones ? true : false,
            child: NavigationBarButton(
              icon: Icon(Icons.group),
              actionFunc: () {
                setState(() {_subScreens = SubScreen.persones ;}) ; 
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ScreenBottomNavigationBar(currentScreen: AppScreensEnum.planning),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.secondaryAccentColor,
            ),
            height: 60,
            margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
            child: StyledText("Aktuelle Woche"),
          ),
          for (String wdn in weekDayNames)
            WeekDay(
              name: wdn,
            )
        ],
      ),
    );
  }
}