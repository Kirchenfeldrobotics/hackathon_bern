import 'package:flutter/material.dart';
import "package:mobile_application/main.dart" ;
import "package:mobile_application/screens/shared_for_screens/screen_enum.dart";
import "package:mobile_application/shared/styled_text.dart" ;
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/shared/styled_button.dart" ;
import "package:mobile_application/screens/home/product_card.dart" ; 
import "package:mobile_application/data_models/product.dart" ; 
import "package:uuid/uuid.dart" ;
import "package:mobile_application/screens/home/home_screen.dart"  ;
import "package:mobile_application/screens/menu_screen/menu_screen.dart" ; 
import "package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart" ;  



class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text("Menu Vorschläge"),
      ), 
      bottomNavigationBar : ScreenBottomNavigationBar(currentScreen: AppScreensEnum.menu)

      ) ; 
  }
} 