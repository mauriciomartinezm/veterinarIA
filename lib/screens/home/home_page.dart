import 'package:flutter/material.dart';
import 'citas_page.dart';
import '../../provider/userProvider.dart';
import 'package:provider/provider.dart';
import './mascotas_page.dart';
import 'info_usuario_page.dart';
import '../login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/backgrounds/fondo_cafe.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      children: [
        superior(context),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 50), //Espacio entre el título y los botones
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        botonCitas(context),
                        const SizedBox(height: 40),
                        botonMisMascotas(context),
                        const SizedBox(height: 40), //Espacio entre los botones
                        botonMiInfo(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget superior(BuildContext context) {
  return Container(
    height: 200,
    width: double.infinity,
    color: Colors.white,
    child: Stack(
      children: [saludo(context), logout(context)],
    ),
  );
}

Widget saludo(BuildContext context) {
  var userProvider = Provider.of<UserProvider>(context);
  // var user = userProvider.user;
  // String nombre = user!.primnombre;

  return Positioned(
    left: 30,
    top: 75,
    child: Row(
      children: [
        Image.asset(
          'assets/images/logoMini_negro.png',
          height: 50,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hola,",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "Guapo",
              // nombre,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Es un gusto tenerte por aquí",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget botonCitas(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
      backgroundColor: const Color.fromARGB(255, 153, 111, 63),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CitasPage()),
      );
    },
    child: const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Citas",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0),
          ),
          Icon(Icons.app_registration_outlined),
        ],
      ),
    ),
  );
}

Widget botonMisMascotas(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 25),
      backgroundColor: const Color.fromARGB(255, 153, 111, 63),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MascotasPage()),
      );
    },
    child: const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mis mascotas",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0),
          ),
          Icon(Icons.pets),
        ],
      ),
    ),
  );
}

Widget botonMiInfo(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 25),
      backgroundColor: const Color.fromARGB(255, 153, 111, 63),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InfoUsuarioPage()),
      );
    },
    child: const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mi información",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0),
          ),
          Icon(Icons.person),
        ],
      ),
    ),
  );
}

Widget logout(BuildContext context) {
  return Positioned(
    left: 370,
    top: 40,
    child: Column(
      children: [
        IconButton(
          icon: const Icon(
            Icons.logout_outlined,
            color: Color.fromARGB(255, 221, 166, 101),
            size: 30.0,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Despidete bien",
                    style: TextStyle(
                      color: Color.fromRGBO(221, 166, 101, 1),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  content: const Text("¿Salir de tu cuenta?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Salir",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Cerraste sesión"),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }, // Deshabilita el botón si disabledButton es igual a 3
        ),
      ],
    ),
  );
}
