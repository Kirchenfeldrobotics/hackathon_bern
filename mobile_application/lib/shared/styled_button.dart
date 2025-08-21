import 'package:flutter/material.dart';
import "package:mobile_application/theme.dart" ; 

class StyledButton extends StatelessWidget {
  const StyledButton({
    required this.buttonChild, 
    required this.actionFunc, 
    super.key
  });

  final Widget buttonChild ;
  final Function() actionFunc ;  

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style : FilledButton.styleFrom(
        backgroundColor : AppColors.primaryColor, 
        foregroundColor : AppColors.textColor, 
        overlayColor : AppColors.secondaryAccentColor!, 
        shape : RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))), 
        minimumSize : const Size(80, 80)
      ), 
      onPressed : actionFunc, 
      child : buttonChild 
    ) ; 
  } 
}