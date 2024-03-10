import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getGender(String name) async {
  final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Falla al cargar el género.');
  }
}