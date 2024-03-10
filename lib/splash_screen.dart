import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarea_seis/pages/home_page.dart';

// ESTA CLASE SE EJECUTA AL INICIO DE LA APP, ANTES DE QUE ENTRE A LA VISTA DE PORTADA.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()));
    });
  }

  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    super.dispose();
  }
  
  // CONSTRUYE EL DISEÑO DEL SPLASH.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
