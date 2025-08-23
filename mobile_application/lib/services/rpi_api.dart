import 'package:http/http.dart' as http;
import 'dart:convert'; 

const String apiIp = "http://10.20.12.167:5000"  ; 

class RpiApiService {
  static Future<List<dynamic>> getMealsByCategory(String categoryName) async {
    final url = Uri.parse("$apiIp/meals/category/$categoryName") ; 

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

  static Future<List<dynamic>> getMealsByName(String menuName) async {
    final url = Uri.parse("$apiIp/meals/search/$menuName");
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
    final url = Uri.parse("$apiIp/meals/details/$menuId");
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

  static void postIngredientsAsImage(String imageFilePath) async {
    final url = Uri.parse("$apiIp/analyze") ; 

    try {
      final request = http.MultipartRequest("POST", url) ; 

      request.files.add(
        await http.MultipartFile.fromPath(
          "image", 
          imageFilePath,  
        )
      ) ;

      final response = await request.send() ; // successful upload in the future 

    } catch (e) {}
  }

}

