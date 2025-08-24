import "package:cloud_firestore/cloud_firestore.dart" ;
import "package:mobile_application/data_models/menu.dart";
import "package:mobile_application/data_models/product.dart";

class FirestoreService {
  static final _menuStoreRef = FirebaseFirestore.instance.collection("menues") ;
  static final _productStoreRef = FirebaseFirestore.instance.collection("products") ;
 

  // add data to firestore 
  static void addMenu(Menu toAddMenu) {
    _menuStoreRef.doc(toAddMenu.menuTitle).set(toAddMenu.toFirestore()) ; 
  } 

  static void removeMenu(Menu toRemoveMenu) {
    _menuStoreRef.doc(toRemoveMenu.menuTitle).delete() ; 
  }

  static void addProduct(Product toAddProduct) {
    _productStoreRef.doc(toAddProduct.productId).set(toAddProduct.toFirestore()) ; 
  }

  static void removeProduct(Product toRemoveProduct) {
    _productStoreRef.doc(toRemoveProduct.productId).delete() ; 
  }
  
  // fetch data 
  static Future<QuerySnapshot<Map<String, dynamic>>> getMenus() async {
    return _menuStoreRef.get() ;  
  }
  
  static Future<QuerySnapshot<Map<String, dynamic>>> getProducts() async {
    return _productStoreRef.get() ;  
  } 

}