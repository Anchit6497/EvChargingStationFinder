import 'dart:convert';
import 'package:http/http.dart' as http;

class BaatoService {
  final String _baseUrl = "https://api.baato.io/api/v1/search";
  final String _accessToken = "bpk.E5Bnstvs6Ydg3ajiRUj8nGYkb5ewqCVgbOzcYcFKxUWR";

  Future<dynamic> search(String query) async {
    try {
      final url = Uri.parse("$_baseUrl?key=$_accessToken&q=$query");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load data: $e");
    }
  }
}
