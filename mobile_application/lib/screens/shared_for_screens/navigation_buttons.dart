import 'package:flutter/material.dart';
import "package:mobile_application/main.dart";
import "package:mobile_application/screens/account_screen/account_screen.dart";
import "package:mobile_application/screens/home/home_screen.dart";
import "package:mobile_application/screens/planning_screen/planning_screen.dart";
import "package:mobile_application/screens/shared_for_screens/screen_enum.dart";
import "package:mobile_application/shared/styled_text.dart";
import "package:mobile_application/theme.dart";
import "package:mobile_application/shared/styled_button.dart";
import "package:mobile_application/screens/home/product_card.dart";
import "package:mobile_application/data_models/product.dart";
import "package:uuid/uuid.dart";
import "package:mobile_application/screens/menu_screen/menu_screen.dart";
import "package:mobile_application/screens/camera_screen/camera_screen.dart";

class NavigationBarButtonWrapper extends StatelessWidget {
  const NavigationBarButtonWrapper({
    required this.isChoosen,
    required this.child,
    super.key,
  });

  final bool isChoosen;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isChoosen) {
      return Container(
        margin: EdgeInsetsGeometry.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromRGBO(200, 80, 70, .15),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }
}

class NavigationBarButton extends StatelessWidget {
  const NavigationBarButton({
    required this.icon,
    required this.actionFunc,
    super.key,
  });

  final Icon icon;
  final Function() actionFunc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color : Color.fromRGBO(20, 0, 50, 1),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: icon,
      onPressed: actionFunc,
    );
  }
}