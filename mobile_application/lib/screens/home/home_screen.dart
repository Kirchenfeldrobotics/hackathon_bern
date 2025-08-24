import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:mobile_application/main.dart" ;
import "package:mobile_application/provider/providers.dart";
import "package:mobile_application/screens/shared_for_screens/screen_enum.dart";
import "package:mobile_application/shared/styled_text.dart" ;
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/shared/styled_button.dart" ;
import "package:mobile_application/screens/home/product_card.dart" ; 
import "package:mobile_application/data_models/product.dart" ; 
import "package:uuid/uuid.dart" ; 
import "package:mobile_application/screens/menu_screen/menu_screen.dart" ; 
import "package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart" ; 


class HomeScreen extends ConsumerStatefulWidget  {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Product> myProducts = ref.watch(productNotifierProvider) ; 
    return Scaffold(
      appBar: AppBar(
        title: Text("Essensliste"),
      ),
      bottomNavigationBar: ScreenBottomNavigationBar(
        currentScreen: AppScreensEnum.home,
      ), 
      body: ListView.builder(
        itemCount: myProducts.length,
        itemBuilder: (_, index) {
          return Container(
            child: ProductCard(myProduct: myProducts[index]),
          );
        },
      ),
    );
  }
}