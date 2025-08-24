import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    required this.productName, 
    required this.productId, 
  }) ; 

  final String productName ; 
  final String productId ; 

  Map<String, String> toFirestore() {
    return {
      "name" : productName, 
      "id" : productId
    } ; 
  }
  factory Product.fromFirestore(
    Map<String, dynamic> data, 
    SnapshotOptions? options
  ) {
    return Product(
      productName : data["name"],
      productId: data["id"]
    ) ; 
  }
}