import "package:cloud_firestore/cloud_firestore.dart" ;
import "package:mobile_application/data_models/menu.dart";

class FirestoreService {
  static final _menuStoreRef = FirebaseFirestore.instance
  .collection("menues") ; 

  // fetch data 
  static Future<QuerySnapshot<Map<String, dynamic>>> getMenus() async {
    return _menuStoreRef.get() ;  
  }

}