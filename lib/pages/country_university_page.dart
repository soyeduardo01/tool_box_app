import 'package:flutter/material.dart';
import 'package:tarea_seis/NavBar.dart';
import 'package:url_launcher/url_launcher.dart'; // Importar el paquete para lanzar URLs
import 'package:tarea_seis/api_pages/country_university_api.dart'; 

class CountryUniversity extends StatefulWidget {
  @override
  _CountryUniversityState createState() => _CountryUniversityState();
}

class _CountryUniversityState extends State<CountryUniversity> {
  final TextEditingController _countryController = TextEditingController();
  List<University> _universities = [];
  bool _isLoading = false;

  Future<void> _searchUniversities(String country) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var universities = await CountryUniversityApi.searchUniversities(country);
      setState(() {
        _isLoading = false;
        _universities = universities;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _universities = [];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('⚠️ Ha ocurrido un error al busca la universidad.'),
            content: Text('$e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),        
        backgroundColor: const Color(0xFF8B0415),
        elevation: 0,
        title: const Text("Universidades por País", 
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_blanco.png'),
            fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el contenedor
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _countryController,
                decoration: const InputDecoration(
                  labelText: 'Ingrese el nombre del país en inglés:',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _searchUniversities(_countryController.text);
                },
                child: const Text('Buscar Universidades'),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _universities.length,
                        itemBuilder: (context, index) {
                          var uni = _universities[index];
                          return GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(uni.webPage));
                            },
                            child: ListTile(
                              title: Text(
                                uni.name,
                                style: const TextStyle(
                                  color: Color(0xFF8B0415),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [ 
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Dominio: ',
                                        ),
                                        TextSpan(
                                          text: uni.domain,
                                          style: const TextStyle(
                                            color: Color(0xFF00008B), // Azul oscuro
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Página web: ',
                                        ),
                                        TextSpan(
                                          text: uni.webPage,
                                          style: const TextStyle(
                                            color: Color(0xFF00008B), // Azul oscuro
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
