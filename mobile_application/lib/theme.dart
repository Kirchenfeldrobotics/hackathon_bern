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

class AppColors {
  static const primaryColor = Colors.red ; 
  static const secondaryColor = Colors.white ; 
  static final secondaryAccentColor = Colors.red[100] ; 
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
    centerTitle: true
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