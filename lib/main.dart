// INSTITUTO TECNOLÓGICO DE LAS AMÉRICAS (ITLA)
// AUTOR: 
//       EDUARDO ANTONIO VICENTE HERRERA (#2022-0799)

import 'package:tarea_seis/pages/contratame_page.dart';
import 'package:tarea_seis/pages/country_university_page.dart';
import 'package:tarea_seis/pages/age_prediction.dart';
import 'package:tarea_seis/pages/gender_prediction.dart';
import 'package:tarea_seis/pages/home_page.dart';
import 'package:tarea_seis/pages/weather_page.dart';
import 'package:tarea_seis/pages/wordpress_page.dart';
import 'package:tarea_seis/splash_screen.dart';
import 'package:flutter/material.dart'; 



// Función principal que establece la implementación de la aplicación
void main() {
  runApp(const MyApp());
}

// Clase principal de la aplicación que hereda de StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Desactiva el banner de depuración en la esquina superior derecha
      debugShowCheckedModeBanner: false,
      // Ruta inicial de la aplicación
      initialRoute: "splashScreen",
      // Define las rutas de la aplicación con los nombres de las pantallas y las clases asociadas
      routes: {
        "splashScreen": (context) => const SplashScreen(), // Pantalla de presentación al inicio de la aplicación
        "home": (context) => const HomePage(), // Pantalla portada de la aplicación.
        "genderPrediction": (context) => const GenderPrediction(), // Pantalla para la predicción del género
        "agePrediction": (context) => const AgePrediction(), // Pantalla para la predicción de la edad   
        "countryUniversity": (context) => CountryUniversity(), // Pantalla para la obtener las universidades por país.
        "weather": (context) => const WeatherPage(), // Pantalla para la obtener el clima actual del país.
        "news": (context) =>  WordpressPage(), // Pantalla para la obtener las noticias actuales del país.
        "contratame": (context) =>  const Contratame(), // Pantalla para la obtener mis informaciones personales.
      },
      // Configuración del tema de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.red, // Color principal
        visualDensity: VisualDensity.adaptivePlatformDensity, // Densidad visual adaptativa
      ),
    );
  }
}


