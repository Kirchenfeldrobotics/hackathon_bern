import 'package:flutter/material.dart';
import "package:mobile_application/main.dart" ;
import "package:mobile_application/screens/shared_for_screens/screen_enum.dart";
import "package:mobile_application/shared/styled_text.dart" ;
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/shared/styled_button.dart" ;
import "package:mobile_application/screens/home/product_card.dart" ; 
import "package:mobile_application/data_models/product.dart" ; 
import "package:uuid/uuid.dart" ; 
import "package:mobile_application/screens/menu_screen/menu_screen.dart" ; 
import "package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart" ; 

final List<Product> dummyProducts = [
  Product(productName : "Jakok's Mate", productId : Uuid().v4()), 
  Product(productName : "KOFFEIN, MEH BITTE", productId : Uuid().v4()), 
  Product(productName: "Nume eis Bier", productId : Uuid().v4()), 
  Product(productName: "Chickenmassala", productId : Uuid().v4()), 
  Product(productName: "KokKai's Chatz", productId : Uuid().v4()), 
] ; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Essensliste"),
      ),
      bottomNavigationBar: ScreenBottomNavigationBar(
        currentScreen: AppScreensEnum.home,
      ), 
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (_, index) {
          return Container(
            child: ProductCard(myProduct: dummyProducts[index]),
          );
        },
      ),
    );
  }
}