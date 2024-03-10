import 'package:flutter/material.dart';
import 'package:tarea_seis/NavBar.dart';
import 'package:tarea_seis/api_pages/age_api.dart'; 

class AgePrediction extends StatefulWidget {
  const AgePrediction({Key? key}) : super(key: key);

  @override
  _AgePredictionState createState() => _AgePredictionState();
}

class _AgePredictionState extends State<AgePrediction> {
  final TextEditingController _nameController = TextEditingController();
  int? _age;
  String _message = '';
  String _imagePath = '';

  Future<void> _predictAge() async {
    try {
      final int age = await getAge(_nameController.text);
      setState(() {
        _age = age;
        if (age <= 35) {
          _message = 'Eres joven. 👦👧';
          _imagePath = 'assets/edades/joven.png';
        } else if (age <= 60) {
          _message = 'Eres adult@. 👨‍🦰👩‍🦰';
          _imagePath = 'assets/edades/adultos.png';
        } else {
          _message = 'Eres ancian@. 👴👵';
          _imagePath = 'assets/edades/ancianos.png';
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falla al cargar la edad del usuario.')),
      );
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
        title: const Text("Predicción de la Edad", 
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Digite el nombre:',
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: _predictAge,
                  child: const  Text('Predecir la Edad'),
                ),
                const SizedBox(height: 30.0),
                if (_age != null)
              Column(
                children: [
                  Text(
                    'Edad: $_age',
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    _message,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50.0),
                  Image.asset(
                    _imagePath,
                    width: 300.0,
                    height: 300.0,
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
}