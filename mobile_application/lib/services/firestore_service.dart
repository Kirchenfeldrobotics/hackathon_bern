import "package:cloud_firestore/cloud_firestore.dart" ;
import "package:mobile_application/data_models/menu.dart";

class FirestoreService {
  static final _menuStoreRef = FirebaseFirestore.instance
  .collection("menues") ; 

  // add data to firestore 
  static void addMenu(Menu toAddMenu) {
    _menuStoreRef.doc(toAddMenu.menuTitle).set(toAddMenu.toFirestore()) ; 
  } 

  static void removeMenu(Menu toRemoveMenu) {
    _menuStoreRef.doc(toRemoveMenu.menuTitle).delete() ; 
  }
  
  // fetch data 
  static Future<QuerySnapshot<Map<String, dynamic>>> getMenus() async {
    return _menuStoreRef.get() ;  
  }

}