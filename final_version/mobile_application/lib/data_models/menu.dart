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

  final String menuId;
  final String menuTitle;
  final String menuCategory;
  final String menuInstructions;
  final String menuImage;
  final String? menuTags;
  final List<Ingredient> menuIngredients;

  // serialize and deserialize 
  Map<String, dynamic > toFirestore() {
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
    Map<String, dynamic> data, 
    SnapshotOptions? options
  ) {
    
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

  factory Menu.fromJson(Map<String, dynamic> json) {
    var ingList = (json['ingredients'] as List)
        .map((i) => Ingredient.fromJson(i))
        .toList();

    return Menu(
      menuId: json['id'] ?? '',
      menuTitle: json['name'] ?? '',
      menuCategory: json['category'] ?? '',
      menuInstructions: json['instructions'] ?? '',
      menuImage: json['image'] ?? '',
      menuTags: json['tags'],
      menuIngredients: ingList,
    );
  }
}


class Ingredient {
  final String ingredient;
  final String measure;

  Ingredient({required this.ingredient, required this.measure});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredient: json['ingredient'] ?? '',
      measure: json['measure'] ?? '',
    );
  }
}