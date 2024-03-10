import 'package:flutter/material.dart';
import 'package:tarea_seis/models/weather_model.dart';
import 'package:tarea_seis/services/weather_service.dart';
import 'package:tarea_seis/NavBar.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('e49b9e5314aabce9c96f6668bdcb7b4f');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/weather/weathercock.png';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/weather/cloudy-day.png';
      case 'clear':
        return 'assets/weather/sun.png';
      case 'scattered clouds':
        return 'assets/weather/cloudy-day.png';
      case 'shower rain':
      case 'rain':
        return 'assets/weather/rain.png';
      case 'snow':
        return 'assets/weather/snow.png';
      case 'heavy thunderstorm':
        return 'assets/weather/thunderstorm.png';
      case 'drizzle':
      case 'few clouds':
        return 'assets/weather/cloudy-day.png';
      case 'thunderstorm':
        return 'assets/weather/storm.png';
      default:
        return 'assets/weather/weathercock.png';
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
        title: const Text(
          "Clima",
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFF8B0415),
                    size: 45.0,
                  ),
                  const SizedBox(height: 10),
                  // nombre de la cuidad
                  Text(
                    _weather?.cityName ?? "Cargando ciudad...",
                    style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 100),
                  Image.asset(
                    getWeatherAnimation(_weather?.mainCondition),
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 150),
                  // Temperatura en grados celsius
                  Text('${_weather?.temperature.round() ??  "Cargando... "}°C', style: const TextStyle(fontSize: 37.0, fontWeight: FontWeight.bold),),
                  // Condicion principal del clima
                  Text(_weather?.mainCondition ?? "", style: const TextStyle(fontSize: 20.0),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
