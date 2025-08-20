import 'package:flutter/material.dart';
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/screens/home/home_screen.dart" ; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme of our app
      theme: primaryTheme, 
      // going to be the home screen (now just a Placeholder)
      home : HomeScreen() 
    );
  }
}
