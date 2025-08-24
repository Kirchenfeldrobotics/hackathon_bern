import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:mobile_application/main.dart";
import "package:mobile_application/provider/providers.dart";
import "package:mobile_application/screens/account_screen/account_screen.dart";
import "package:mobile_application/screens/home/home_screen.dart";
import "package:mobile_application/screens/planning_screen/planning_screen.dart";
import "package:mobile_application/screens/shared_for_screens/screen_enum.dart";
import "package:mobile_application/services/api.dart";
import "package:mobile_application/shared/styled_text.dart";
import "package:mobile_application/theme.dart";
import "package:mobile_application/shared/styled_button.dart";
import "package:mobile_application/screens/home/product_card.dart";
import "package:mobile_application/data_models/product.dart";
import "package:uuid/uuid.dart";
import "package:mobile_application/screens/menu_screen/menu_screen.dart";
import "package:mobile_application/screens/camera_screen/camera_screen.dart";
import "package:mobile_application/screens/shared_for_screens/navigation_buttons.dart" ; 

// do NOT use outside of this file!


class ScreenBottomNavigationBar extends ConsumerWidget {
  const ScreenBottomNavigationBar({required this.currentScreen, super.key});

  final AppScreensEnum currentScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsetsGeometry.only(top: 20, right: 15, left : 15, bottom : 55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryAccentColor,
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavigationBarButtonWrapper(
            isChoosen: currentScreen == AppScreensEnum.home ? true : false,
            child: NavigationBarButton(
              icon: Icon(Icons.home),
              actionFunc: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (ctx) => HomeScreen()),
                );
              },
            ),
          ),
          SizedBox(width: 10),
          NavigationBarButtonWrapper(
            isChoosen: currentScreen == AppScreensEnum.menu ? true : false,
            child: NavigationBarButton(
              icon: Icon(Icons.menu_book),
              actionFunc: () {
                
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return MenuScreen() ; 
                })) ;  
              }
                
                
              
              
            ),
          ),
          SizedBox(width: 10),
          NavigationBarButton(
            icon: Icon(Icons.add, weight: 1000),
            actionFunc: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => CameraScreen()),
              );
            },
          ),

          SizedBox(width: 10),
          NavigationBarButtonWrapper(
            isChoosen: currentScreen == AppScreensEnum.planning ? true : false,
            child: NavigationBarButton(
              icon: Icon(Icons.calendar_month),
              actionFunc: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PlanningScreen()),
                );
              },
            ),
          ),
          SizedBox(width: 10),
          NavigationBarButtonWrapper(
            isChoosen: currentScreen == AppScreensEnum.account ? true : false,
            child: NavigationBarButton(
              icon: Icon(Icons.account_circle),
              actionFunc: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AccountScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
