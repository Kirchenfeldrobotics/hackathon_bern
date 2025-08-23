import 'package:http/http.dart' as http;
import 'dart:convert'; // Required for json.decode

const String apiIp = "Rasberry pi IP:Port"  ; 

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
    final url = Uri.parse("$apiIp/meals/category/$menuName") ; 

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

  static Future<>
}

