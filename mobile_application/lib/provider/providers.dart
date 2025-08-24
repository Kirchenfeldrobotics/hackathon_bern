import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/data_models/menu.dart';
import 'package:mobile_application/data_models/product.dart';
import 'package:mobile_application/screens/menu_screen/menu_screen.dart';
import 'package:mobile_application/services/api.dart';
import 'package:mobile_application/services/firestore_service.dart';
import "dart:convert" ; 

class MenuNotifier extends StateNotifier<List<Menu>> {
  MenuNotifier() : super([]);

  // A new method to fetch all menus and update the state
  Future<void> loadMenus() async {
    final menuSnapshot = await FirestoreService.getMenus();
    final List<Menu> menus = [
      for (final doc in menuSnapshot.docs)
        Menu.fromFirestore(doc.data(), null)
    ];
    state = menus;
  }

  void addMenu(Menu toAddMenu) {
    FirestoreService.addMenu(toAddMenu);
    state = [...state, toAddMenu];
  }

  void removeMenu(Menu toRemoveMenu) {
    FirestoreService.removeMenu(toRemoveMenu);
    final List<Menu> newList = [...state];
    newList.removeWhere((m) => m.menuTitle == toRemoveMenu.menuTitle);
    state = newList;
  }
}

final menuNotifierProvider = StateNotifierProvider<MenuNotifier, List<Menu>>((ref) {
  return MenuNotifier();
});

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  // A new method to fetch all products and update the state
  Future<void> loadProducts() async {
    final productSnapshot = await FirestoreService.getProducts();
    final List<Product> products = [
      for (final doc in productSnapshot.docs)
        Product.fromFirestore(doc.data(), null)
    ];
    state = products;
  }

  void addProduct(Product toAddProduct) {
    FirestoreService.addProduct(toAddProduct);
    state = [...state, toAddProduct];
  }

  void removeProduct(Product toRemoveProduct) {
    FirestoreService.removeProduct(toRemoveProduct);
    final List<Product> newList = [...state];
    newList.removeWhere((p) => p.productId == toRemoveProduct.productId);
    state = newList;
  }
}

final productNotifierProvider = StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier();
});

final menuCategoryFutureProvider = FutureProvider<List<Menu>>((ref) async {
  final List<Menu> listResponse = await ApiService.getMealsByCategory("Seafood");
  print("LITLLE RESPONE: $listResponse") ; 
  return listResponse;
});