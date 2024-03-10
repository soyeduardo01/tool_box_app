import 'package:flutter/material.dart';
import 'package:tarea_seis/NavBar.dart';

// ESTA CLASE SE EJECUTA AL INICIO DE LA APP, ANTES DE QUE ENTRE A LA VISTA DE PORTADA.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  
  @override
  void initState(){
    super.initState();
  }

  
  // CONSTRUYE EL DISEÑO DEL SPLASH.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF8B0415),
        elevation: 0,
        title: const Text(
          "Inicio",
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
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              SizedBox(height: 30),
              Image(
                image: AssetImage('assets/logo.png'),
                width: 300.0,
              ),
              SizedBox(height: 50),
              Text(
                'Tool Box',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 40),                
            ],
          ),
        ),
      ),
    );
  }
}
