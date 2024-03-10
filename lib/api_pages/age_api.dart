import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> getAge(String name) async {
  final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['age'] as int;
  } else {
    throw Exception('Falla al cargar la edad de la persona.');
  }
}
