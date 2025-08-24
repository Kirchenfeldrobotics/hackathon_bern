import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart" ; 

class StyledText extends StatelessWidget {
  const StyledText(
    this.myText, 
    {super.key}
  );

  final String myText ; 

  @override
  Widget build(BuildContext context) {
    return Text(
      myText, 
      style : GoogleFonts.raleway(
        textStyle: Theme.of(context).textTheme.bodyMedium
      )
    );
  }
}

class StyledHeading extends StatelessWidget {
  const StyledHeading(
    this.myText, 
    {super.key}
  );

  final String myText ; 

  @override
  Widget build(BuildContext context) {
    return Text(
      myText, 
      style : GoogleFonts.raleway(
        textStyle: Theme.of(context).textTheme.headlineMedium
      )
    );
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(
    this.myText, 
    {super.key}
  );

  final String myText ; 

  @override
  Widget build(BuildContext context) {
    return Text(
      myText, 
      style : GoogleFonts.raleway(
        textStyle: Theme.of(context).textTheme.titleMedium
      )
    );
  }
}