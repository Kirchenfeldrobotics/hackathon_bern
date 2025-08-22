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
// Color.fromRGBO(210, 70, 50, 1)

class AppColors {
  static const primaryColor = Color.fromRGBO(120, 60, 110, 1) ; 
  static const secondaryColor = Color.fromRGBO(220, 230, 240, 1) ; 
  static const secondaryAccentColor = Color.fromRGBO(180, 190, 230, 1) ; 
  static const textColor = Colors.black ;
  static const titleColor = Colors.black ;  
}

ThemeData primaryTheme = ThemeData( 
  useMaterial3: true,
  
  colorScheme : ColorScheme(
    brightness : Brightness.dark, 
    primary : AppColors.primaryColor,
    onPrimary : AppColors.textColor, 
    secondary : AppColors.secondaryAccentColor!,
    onSecondary : AppColors.textColor,
    surface : AppColors.secondaryColor,
    onSurface : AppColors.textColor,
    error : Colors.yellow,
    onError : AppColors.textColor,
  ), 
  
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secondaryAccentColor!, 
    foregroundColor: AppColors.textColor, 
    centerTitle: true, 
    titleTextStyle : TextStyle(
      color : AppColors.titleColor, 
      fontSize : 26, 
      fontWeight : FontWeight.w700
    )
  ),
  
  textTheme : TextTheme(
    bodyMedium : TextStyle(
      color : AppColors.textColor, 
      fontSize : 16, 
      letterSpacing : 1, 
    ), 
    headlineMedium : TextStyle(
      color : AppColors.titleColor, 
      fontSize : 16, 
      fontWeight : FontWeight.w700, 
      letterSpacing : 1, 
    ), 
    titleMedium : TextStyle(
      color : AppColors.titleColor, 
      fontSize : 18, 
      fontWeight : FontWeight.w700, 
      letterSpacing : 1, 
    ), 
  ), 
  // all relevant widgets
  pageTransitionsTheme : PageTransitionsTheme(
    builders : {
      TargetPlatform.android : _NoTransitionAnimation()
    }
  )
) ; 