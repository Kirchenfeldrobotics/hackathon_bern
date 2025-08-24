import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  Menu({
    required this.menuId, 
    required this.menuTitle, 
    required this.menuInstructions, 
    required this.menuIngredients, 
    required this.menuCategory, 
    required this.menuImage, 
    required this.menuTags
  }) ; 

  final String menuId ; 
  final String menuTitle ; 
  final String menuInstructions ; 
  final String menuIngredients ; 
  final String menuCategory ; 
  final String menuImage ; 
  final String menuTags ; 

  // serialize and deserialize 
  Map<String, String > toFirestore() {
    return {
      "id" : menuId, 
      "name" : menuTitle, 
      "category" : menuCategory, 
      "instructions" : menuInstructions, 
      "image" : menuImage, 
      "tags" : menuTags, 
      "indegredients" : menuIngredients
    } ; 
  }

  factory Menu.fromFirestore(
    DocumentSnapshot<Map<String, String>> snapshot, 
    SnapshotOptions? options
  ) {
    
    final Map<String, dynamic> data = snapshot.data()! ; 

    return Menu(
      menuId : data["title"], 
      menuTitle : data["name"], 
      menuInstructions : data["instructions"], 
      menuIngredients : data["indegredients"], 
      menuCategory : data["category"], 
      menuImage : data["image"], 
      menuTags : data["tags"]
    ) ; 
  }

}