import 'package:flutter/material.dart';
import 'package:tarea_seis/NavBar.dart';
import 'package:url_launcher/url_launcher.dart'; 

/// Esta clase representa la página "¡Contrátame!" que muestra información de contacto y enlaces a redes sociales.
class Contratame extends StatefulWidget {
  const Contratame({Key? key}) : super(key: key);

  @override
  _ContratameState createState() => _ContratameState();
}


class _ContratameState extends State<Contratame> {

  /// Construye la UI de la página "¡Contrátame!".
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), 
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF8B0415),
        elevation: 0,
        title: const Text(
          "¡Contrátame!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo_blanco.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/contratame/foto_eduardo.jpeg'),
                  radius: 170, 
                ),
                const SizedBox(height: 50), 
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Color(0xFF8B0415),),
                      children: [
                        TextSpan(
                          text: 'Nombre:\n ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        TextSpan(text: 'Eduardo Vicente\n\n', style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: 'Teléfono: \n',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        TextSpan(text: '+829-111-0000\n\n', style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: 'Correo electrónico:\n ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        TextSpan(text: 'soyeduardovicente@gmail.com', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://www.linkedin.com/in/eduardo-antonio-vicente-herrera/'));
                      },
                      child: const Image(
                        image: AssetImage('assets/contratame/linkedin_icon.png'),
                        width: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://github.com/soyeduardo01'));
                      },
                      child: const Image(
                        image: AssetImage('assets/contratame/github_icon.png'),
                        width: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://www.instagram.com'));
                      },
                      child: const Image(
                        image: AssetImage('assets/contratame/instagram_icon.png'),
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Función para abrir una URL en un navegador externo.
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No se pudo abrir la URL.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
