import 'package:flutter/material.dart';

class _NoTransitionAnimation extends PageTransitionsBuilder  {
  const _NoTransitionAnimation() ; 

  @override 
  Widget buildTransitions<T>(
    PageRoute<T> route, 
    BuildContext context, 
    Animation<double> animation, 
    Animation<double> secondaryAnimation, 
    Widget child
  ) {
    return child ;  
  }
}

ThemeData primaryTheme = ThemeData( 
  // colorScheme
  textTheme : TextTheme(
  ),
  // all relevant widgets
  pageTransitionsTheme : PageTransitionsTheme(
    builders : {
      TargetPlatform.android : _NoTransitionAnimation()
    }
  )
) ; 