import 'package:flutter/material.dart';
import 'package:tarea_seis/NavBar.dart';
import 'package:tarea_seis/api_pages/gender_api.dart'; 

class GenderPrediction extends StatefulWidget {
  const GenderPrediction({Key? key}) : super(key: key);

  @override
  _GenderPredictionState createState() => _GenderPredictionState();
}

class _GenderPredictionState extends State<GenderPrediction> {
  final TextEditingController _nameController = TextEditingController();
  String _genderText = '';
  late String _imagePath = 'assets/genero/niño-niña.png';
  Color _color = Colors.pink;

  Future<void> _predictGender() async {
    try {
      final Map<String, dynamic> gender = await getGender(_nameController.text);
      setState(() {
        if (gender['gender'] == 'male') {
          _imagePath = 'assets/genero/niño.png';
          _genderText = 'Eres un niño. 👦';
          _color = Colors.blue;
        } else {
          _imagePath = 'assets/genero/niña.png';
          _genderText = 'Eres una niña. 👧';
          _color = Colors.pink;
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Falla al cargar el género.')));
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
        title: const Text("Predicción del Género", 
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
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _predictGender,
                  child: const  Text('Predecir el Género'),
                ),
                const SizedBox(height: 30),
                Text(
                  _genderText,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _color),
                ),
                const SizedBox(height: 30),
                _imagePath.isNotEmpty
                    ? Image.asset(
                        _imagePath,
                        width: 337,
                        height: 337,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
