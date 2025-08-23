import 'dart:io';
import 'package:http/http.dart' as http;
 
class ApiService {
  final String baseUrl = "http://10.20.12.167:5000";
  Future<String?> uploadImage(String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/analyze'),
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

}