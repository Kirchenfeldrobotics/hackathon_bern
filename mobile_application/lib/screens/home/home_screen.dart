import 'package:flutter/material.dart';
import "package:mobile_application/main.dart" ;
import "package:mobile_application/shared/styled_text.dart" ;
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/shared/styled_button.dart" ;
import "package:mobile_application/screens/home/product_card.dart" ; 
import "package:mobile_application/data_models/product.dart" ; 
import "package:uuid/uuid.dart" ; 
import "package:mobile_application/screens/menu_screen/menu_screen.dart" ; 

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
  
  // eventuall nice to have, faus nid direkt zu kamera
  
  // OverlayEntry? _overlayEntry ; 

  // void showOverlay(BuildContext ctx) {
  //   final overlay = Overlay.of(ctx) ; 

  //    _overlayEntry = OverlayEntry(
  //     builder : (context) {
  //       return Positioned(
  //         child : Container()
  //       ) ; 
  //     },
  //   ) ; 
  //   overlay.insert(_overlayEntry!) ;
  // }

  // void removeOverly() {
  //   _overlayEntry?.remove() ; 
  //   _overlayEntry = null ; 
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Essensliste"),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 50,
            color: AppColors.secondaryAccentColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.menu_book),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
                  },
                ),
                SizedBox(width: 150),
              ],
            ),
          ),
          Positioned(
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.secondaryAccentColor!,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.black,
                onPressed: () {},
              ),
            ),
          ),
        ],
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