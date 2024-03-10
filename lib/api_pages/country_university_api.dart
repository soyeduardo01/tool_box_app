import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryUniversityApi {
  static Future<List<University>> searchUniversities(String country) async {
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=$country'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List<dynamic>;
      return data.map((uni) => University.fromJson(uni)).toList();
    } else {
      throw Exception('Error al buscar las universidades.');
    }
  }
}

class University {
  final String name;
  final String domain;
  final String webPage;

  University({
    required this.name,
    required this.domain,
    required this.webPage,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '',
      domain: json['domains'] != null ? json['domains'][0] : '',
      webPage: json['web_pages'] != null ? json['web_pages'][0] : '',
    );
  }
}
