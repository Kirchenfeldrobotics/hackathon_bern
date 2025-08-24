import 'package:flutter/material.dart';
import 'package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart';
import 'package:mobile_application/screens/shared_for_screens/screen_enum.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScreenBottomNavigationBar(currentScreen: AppScreensEnum.account), 
      body : Container(
        
      )
    ) ;
  }
}