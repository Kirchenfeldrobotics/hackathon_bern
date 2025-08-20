import 'package:flutter/material.dart';
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/screens/home/home_screen.dart" ; 
import "package:flutter_riverpod/flutter_riverpod.dart" ;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root widget
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: '',
        // theme of our app
        theme: primaryTheme, 
        // going to be the home screen (now just a Placeholder)
        home : HomeScreen() 
      ),
    );
  }
}
