import 'package:flutter/material.dart';
import 'package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart';
import 'package:mobile_application/screens/shared_for_screens/screen_enum.dart';
import 'package:mobile_application/services/rpi_api.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScreenBottomNavigationBar(currentScreen: AppScreensEnum.account), 
      body : Container(
        margin : EdgeInsetsGeometry.all(50),
        child: FilledButton(
          onPressed : () async {
            final List<dynamic> kp = await RpiApiService.getMealsByCategory("Vegan") ; 
            print("API TEST: $kp") ; 
          }, 
          child : Text("API TEST")
        ),
      )
    ) ;
  }
}