import 'package:http/http.dart' as http;
import 'dart:convert'; 

// import IP address of the Raspberry Pi server
const String apiIp = "http://192.168.1.42:5000";  // ✅ added "http://" protocol

class RpiApiService {
  // get meals by category
  static Future<List<dynamic>> getMealsByCategory(String categoryName) async {
    final url = Uri.parse("$apiIp/meals/category/$categoryName");  // unchanged

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [];
      }

    } catch (e) {
      return [];
    }
  }

  // get meals by name
  static Future<List<dynamic>> getMealsByName(String menuName) async {
    final url = Uri.parse("$apiIp/meals/search/$menuName");  // ✅ fixed endpoint

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // get meal details by ID
  static Future<dynamic> getMealDetailById(String menuId) async {
    final url = Uri.parse("$apiIp/meals/details/$menuId");  // ✅ fixed endpoint

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  // post image for ingredient analysis
  static void postIngredientsAsImage(String imageFilePath) async {
    final url = Uri.parse("$apiIp/analyze");  // unchanged

    try {
      final request = http.MultipartRequest("POST", url);

      request.files.add(
        await http.MultipartFile.fromPath(
          "image", 
          imageFilePath,  
        )
      );

      final response = await request.send(); // successful upload in the future

    } catch (e) {}
  }

}