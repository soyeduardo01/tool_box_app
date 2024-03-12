// wordpress_page.dart
import 'package:flutter/material.dart';
import 'package:tarea_seis/NavBar.dart';
import 'package:tarea_seis/api_pages/wordpress_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html_unescape/html_unescape.dart';

class WordpressPage extends StatefulWidget {
  @override
  _WordpressPageState createState() => _WordpressPageState();
}

class _WordpressPageState extends State<WordpressPage> {
  WordpressApi api = WordpressApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF8B0415),
        elevation: 0,
        title: const Text(
          "Noticias de Último Minuto",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 30),
          const Image(
            image: AssetImage('assets/cdn_logo.png'),
            width: 270.0,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: FutureBuilder(
              future: api.fetchPosts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final List posts = snapshot.data;
                  final List displayedPosts = posts.take(3).toList();
                  return ListView.builder(
                    itemCount: displayedPosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      var post = displayedPosts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        child: Card(
                          color: const Color.fromRGBO(247, 241, 241, 1), // Color de fondo azul
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0), // Esquinas redondeadas
                          ),
                          child: Column(
                            children: <Widget>[
                              Image.network(post['featured_image_url']),
                              ListTile(
                                title: Text(post['title']['rendered'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8B0415))),
                                subtitle: Text(_stripHtmlTagsAndEntities(post['excerpt']['rendered'])), 
                              ),
                              TextButton(
                                child: const Text(
                                  'Leer Más...',
                                  style: TextStyle(color: Color(0xFF8B0415)),
                                ),
                                onPressed: () async {
                                  final url = Uri.parse(post['link']);
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



// Función para eliminar etiquetas HTML y entidades
String _stripHtmlTagsAndEntities(String htmlString) {
  // Eliminar etiquetas HTML
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  String strippedString = htmlString.replaceAll(exp, '');
  
  // Decodificar entidades HTML
  HtmlUnescape unescape = HtmlUnescape();
  String decodedString = unescape.convert(strippedString);
  
  return decodedString;
}