import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_seis/models/weather_model.dart';

class WeatherService {
  static const urlBase = 'http://api.openweathermap.org/data/2.5/weather'; 
  late final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$urlBase?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200){  
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falla al cargar los datos del clima. Código de estado: ${response.statusCode}');
    }
  }

  Future<String> getCurrentCity() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude); 

      String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;

      if (city != null) {
        return city;
      } else {
        throw Exception('No se pudo determinar la ciudad actual.');
      }
    } catch (e) {
      throw Exception('Error al obtener la ubicación actual: $e');
    }
  }
}
