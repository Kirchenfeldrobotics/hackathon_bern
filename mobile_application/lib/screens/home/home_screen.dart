import 'package:flutter/material.dart';
import "package:mobile_application/main.dart" ; 
import "package:mobile_application/shared/styled_text.dart" ; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : StyledHeading("Home"),
      ), 
      bottomNavigationBar : Container(
        height : 60,
        padding : EdgeInsets.symmetric(vertical : 12, horizontal : 20), 
        child : Row(
          children : [
            IconButton(
              icon : Icon(
                Icons.home, 
                size : 25, 
              ), 
              onPressed : () {
                // Navigator.push(context, MaterialPageRoute(builder :(context) => MyApp())) ; 
              }
            ), 
          ]
        )
      ), 
      body : Container(
      )
    );
  }
}