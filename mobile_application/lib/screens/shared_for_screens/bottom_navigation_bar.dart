import 'package:flutter/material.dart';
import "package:mobile_application/main.dart" ;
import "package:mobile_application/screens/account_screen/account_screen.dart";
import "package:mobile_application/screens/home/home_screen.dart";
import "package:mobile_application/screens/planning_screen/planning_screen.dart";
import "package:mobile_application/screens/shared_for_screens/screen_enum.dart";
import "package:mobile_application/shared/styled_text.dart" ;
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/shared/styled_button.dart" ;
import "package:mobile_application/screens/home/product_card.dart" ; 
import "package:mobile_application/data_models/product.dart" ; 
import "package:uuid/uuid.dart" ; 
import "package:mobile_application/screens/menu_screen/menu_screen.dart" ; 


// do NOT use outside of this file! 
class NavigationBarButtonWrapper extends StatelessWidget {
  const NavigationBarButtonWrapper({
    required this.isChoosen, 
    required this.child, 
    super.key
  });

  final bool isChoosen ; 
  final Widget child ; 

  @override
  Widget build(BuildContext context) {
    if (isChoosen) {
      return Container(
      margin : EdgeInsetsGeometry.symmetric(vertical : 2), 
      decoration : BoxDecoration(
      borderRadius : BorderRadius.circular(30), 
      color : Color.fromRGBO(210, 70, 50, 0.2)
      ), 
      child: child 
    ) ; 
    } else {
      return child ; 
    }
    
  }
}

class NavagtionBarButton extends StatelessWidget {
  const NavagtionBarButton({
    required this.icon, 
    required this.actionFunc, 
    super.key
  });

  final Icon icon ; 
  final Function() actionFunc ; 

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color : Color.fromRGBO(15, 0, 70, 1), 
        highlightColor : Colors.transparent, 
        splashColor : Colors.transparent,         
        icon : icon, 
        onPressed : actionFunc
    ) ; 
  }
}

class ScreenBottomNavigationBar extends StatelessWidget {
  const ScreenBottomNavigationBar({
    required this.currentScreen, 
    super.key
  });

  final AppScreensEnum currentScreen ; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin : EdgeInsetsGeometry.symmetric(vertical : 20, horizontal : 15),
      decoration : BoxDecoration(
        borderRadius : BorderRadius.circular(20), 
        color : AppColors.secondaryAccentColor, 
      ), 
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavigationBarButtonWrapper(
            isChoosen : currentScreen == AppScreensEnum.home ? true : false, 
            child : NavagtionBarButton(
              icon : Icon(Icons.home),
              actionFunc : () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomeScreen())) ; 
              }
            ),
          ),
          SizedBox(width: 10), 
          NavigationBarButtonWrapper(
            isChoosen : currentScreen == AppScreensEnum.menu ? true : false, 
            child: NavagtionBarButton(
              icon : Icon(Icons.menu_book),
              actionFunc : () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => MenuScreen())) ; 
              }
            ),
          ),
          SizedBox(width : 10), 
          // central widget
          NavagtionBarButton(
            icon: Icon(Icons.add, weight : 1000),
            actionFunc: () {

            },
          ),
          SizedBox(width : 10), 
          NavigationBarButtonWrapper(
            isChoosen : currentScreen == AppScreensEnum.planning ? true : false, 
            child: NavagtionBarButton(
              icon: Icon(Icons.calendar_month),
              actionFunc: () {
                Navigator.push(context, MaterialPageRoute(builder:   (context) => PlanningScreen()));
              },
            ),
          ),
          SizedBox(width : 10), 
          NavigationBarButtonWrapper(
            isChoosen: currentScreen == AppScreensEnum.account ? true : false,
            child: NavagtionBarButton(
              icon: Icon(Icons.account_circle),
              actionFunc : () {
                Navigator.push(context, MaterialPageRoute(builder:   (context) => AccountScreen()));
              },
            ),
          ),
          
        ],
      ),
          ) ; 
  }
}