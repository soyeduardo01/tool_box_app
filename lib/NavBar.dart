import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// Esta clase nos crea un menú lateral que tiene el acceso a las diferentes vistas de la app.
class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Tool Box',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              'Eduardo Vicente (#2022-0799).',
              style: TextStyle(color: Colors.white),),
            currentAccountPicture: 
            CircleAvatar(
              backgroundImage: AssetImage('assets/navbar/perfil.png'),
              radius: 45, // Ajusta el radio según sea necesario
            ),
            decoration: BoxDecoration(
              color: Color(0xFF8B0415),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/navbar/portada_perfil.jpg'),
              ),
            ),
          ),
          // SE PROCEDE A LISTAR CADA UNO DE LOS ACCESOS A LAS VISTAS Y SE LE COLOCA UN ICONO.
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color(0xFF8B0415), 
            ),
            title: const Text('Inicio'),
            onTap: () => Navigator.pushNamed(context, 'home'),
          ),
          ListTile(
            leading: const Icon(
              Icons.wc,
              color: Color(0xFF8B0415), 
            ),
            title: const Text('Predicción del Género'),
            onTap: () => Navigator.pushNamed(context, 'genderPrediction'),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings_accessibility,
              color: Color(0xFF8B0415), 
            ),
            title: const Text('Predicción de la Edad'),
            onTap: () => Navigator.pushNamed(context, 'agePrediction'),
          ),
          ListTile(
            leading: const Icon(
              Icons.school,
              color: Color(0xFF8B0415), 
            ),
            title: const Text('Universidades por País'),
            onTap: () => Navigator.pushNamed(context, 'countryUniversity'),
          ),
          ListTile(
            leading: const Icon(
              Icons.sunny_snowing,
              color: Color(0xFF8B0415), 
            ),
            title: const Text('Clima'),
            onTap: () => Navigator.pushNamed(context, 'weather'),
          ),
          ListTile(
            leading: const Icon(
              Icons.newspaper,
              color: Color(0xFF8B0415), 
            ),
            title: const Text('Noticias de Último Minuto'),
            onTap: () => Navigator.pushNamed(context, 'news'),
          ),
          ListTile(
            leading: const Icon(
              Icons.contacts,
              color: Color(0xFF8B0415), 
            ),
            title: const Text('¡Contrátame!'),
            onTap: () => Navigator.pushNamed(context, 'contratame'),
          ),

          const Divider(),
          ListTile(
          title: const Text('Salir'),
          leading: const Icon(
            Icons.contacts,
            color: Colors.black,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmación'),
                  content: const Text('¿Está seguro de que desea salir de la aplicación?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        SystemNavigator.pop();
                      },
                      child: const Text('Salir'),
                    ),
                  ],
                );
              },
            );
          },
        ),

          const Divider(),
        ],
      ),
    );
  }
}