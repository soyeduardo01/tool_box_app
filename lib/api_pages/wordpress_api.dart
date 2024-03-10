// wordpress_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordpressApi {
  final String apiUrl = "https://cdn.com.do/wp-json/wp/v2/posts";

  Future<List> fetchPosts() async {
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List posts = json.decode(response.body);
      // Obtener las imágenes destacadas para cada publicación
      for (var post in posts) {
        post['featured_image_url'] = await fetchFeaturedImage(post['featured_media']);
      }
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<String> fetchFeaturedImage(int mediaId) async {
    final mediaUrl = "https://cdn.com.do/wp-json/wp/v2/media/$mediaId";
    var response = await http.get(Uri.parse(mediaUrl));
    if (response.statusCode == 200) {
      var media = json.decode(response.body);
      return media['guid']['rendered'];
    } else {
      throw Exception('Failed to load featured image');
    }
  }
}
