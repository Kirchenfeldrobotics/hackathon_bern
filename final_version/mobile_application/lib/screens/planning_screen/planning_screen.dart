import 'package:flutter/material.dart';
import 'package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart';
import 'package:mobile_application/screens/shared_for_screens/navigation_buttons.dart';
import 'package:mobile_application/screens/shared_for_screens/screen_enum.dart';
import 'package:mobile_application/shared/styled_text.dart';
import 'package:mobile_application/theme.dart';

const List<String> weekDayNames = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"] ; 

const Map<String, List<String>> hardCodedMeals = {
  "Mo": ["Rührei", "Spaghetti", "Kartoffelsalat"],
  "Di": ["Waffeln", "Nudelsuppe", "Pizza"],
  "Mi": ["Pancakes", "Süßkartoffelsuppe", "Risotto"],
  "Do": ["Haferflocken", "Kartoffelknödel", "Chili con Carne"],
  "Fr": ["Toast", "Ravioli", "Sushi"],
  "Sa": ["Croissant", "Burger", "Döner"],
  "So": ["Brötchen", "Lasagne", "Käsefondue"]
};

enum SubScreen {
  calendar, 
  persones
}

class WeekDay extends StatelessWidget {
  const WeekDay({
    required this.name, 
    required this.meals,
    super.key
  });

  final String name;
  final List<String> meals;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin : const EdgeInsets.symmetric(horizontal : 15, vertical : 5), 
      child: Card(
        color : AppColors.secondaryAccentColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        child : ExpansionTile(
          title : StyledTitle(name), 
          trailing : const Icon(Icons.expand_more), 
          expandedCrossAxisAlignment : CrossAxisAlignment.end,
          children : [
            for (int i = 0; i < meals.length; i++)
              Container(
                margin : const EdgeInsets.only(left : 20), 
                child: Row(
                  children : [
                    StyledHeading("${["Morgen", "Mittag", "Abend"][i]}: "), 
                    StyledText(meals[i])
                  ]
                ),
              )
          ]
        ) 
      ),
    );   
  }
}

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  SubScreen _subScreens = SubScreen.calendar; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menüplan"),
        actions: [
          NavigationBarButtonWrapper(
            isChoosen: _subScreens == SubScreen.calendar,
            child: NavigationBarButton(
              icon: const Icon(Icons.calendar_today),
              actionFunc: () {
                setState(() {_subScreens = SubScreen.calendar;}); 
              },
            ),
          ),
          NavigationBarButtonWrapper(
            isChoosen: _subScreens == SubScreen.persones,
            child: NavigationBarButton(
              icon: const Icon(Icons.group),
              actionFunc: () {
                setState(() {_subScreens = SubScreen.persones;}); 
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ScreenBottomNavigationBar(currentScreen: AppScreensEnum.planning),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.secondaryAccentColor,
              ),
              height: 60,
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
              child: const StyledText("Aktuelle Woche"),
            ),
            for (String wdn in weekDayNames)
              WeekDay(
                name: wdn,
                meals: hardCodedMeals[wdn]!,
              ),
          ],
        ),
      ),
    );
  }
}