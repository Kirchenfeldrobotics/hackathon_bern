import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_application/data_models/menu.dart'; 

final String apiUrl = "http://147.87.228.59:5000";
 
class ApiService {
  static Future<String?> uploadImage(String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/analyze'),
      ); 
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imagePath,

      ));
 
      var response = await request.send();

      if (response.statusCode == 200) {

        final respStr = await response.stream.bytesToString();

        return respStr; // JSON-Antwort

      } else {

        return "Fehler: ${response.statusCode}";

      }

    } catch (e) {

      return "Exception: $e";

    }

  }

    static Future<List<Menu>> getMealsByCategory(String categoryName) async {
      final response = await http.get(Uri.parse(
      '$apiUrl/meals/category/$categoryName'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((meal) => Menu.fromJson(meal)).toList();
  } else {
      throw Exception('Failed to load meals');
  }
   }
  static Future<List<dynamic>> getMealsByName(String menuName) async {
    final url = Uri.parse("$apiUrl/meals/search/$menuName");
    try {
      final response = await http.get(url) ;
      if (response.statusCode == 200) {
        return json.decode(response.body) ; 
      } else {
        return [] ;
      }
    } catch (e) {
      return [] ;
    }
  }

  static Future<dynamic> getMealDetailById(String menuId) async {
    final url = Uri.parse("$apiUrl/meals/details/$menuId");
    try {
      final response = await http.get(url) ; 
      if (response.statusCode == 200) {
        return json.decode(response.body) ; 
      } else {
        return "" ; 
      }
    } catch (e) {
      return "" ; 
    }
  }

  // static Future<List<dynamic>> getCommonMelas() async {
  //   final url = Uri.parse("$apiUrl/meals/details/$menuId");
  //   try {
  //     final
  //   }
  // }
}