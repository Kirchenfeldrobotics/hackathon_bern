import 'package:flutter/material.dart';
import "package:mobile_application/main.dart" ; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text("Home"),
        centerTitle : true, 
        backgroundColor : Colors.grey
      ), 
      bottomNavigationBar : Container(
        color : Colors.grey, 
        height : 60,
        padding : EdgeInsets.symmetric(vertical : 12, horizontal : 20), 
        child : Row(
          children : [
            IconButton(
              icon : Icon(
                Icons.home, 
                size : 25, 
                color : Colors.blueGrey), 
              onPressed : () {
                // Navigator.push(context, MaterialPageRoute(builder :(context) => MyApp())) ; 
              }
            ), 
          ]
        )
      ), 
      body : Container(
        color : Colors.white
      )
    );
  }
}