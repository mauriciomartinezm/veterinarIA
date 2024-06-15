import 'package:flutter/material.dart';
import '../../barra_inferior.dart';
import 'citas_page.dart';
import '../../provider/userProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
      bottomNavigationBar:
          const MiBottomAppBar(disabledButton: 2), // Deshabilita el Home
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
                SizedBox(
                  width: 250, // tamaño botón
                  child: botonCitas(context),
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
      children: [
        saludo(context),
      ],
    ),
  );
}

Widget saludo(BuildContext context) {
  var userProvider = Provider.of<UserProvider>(context);
   var user = userProvider.user;
   String nombre = user!.primnombre;

  return Positioned(
    left: 30,
    top: 75,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hola,",
          style: TextStyle(fontSize: 25),
        ),
        Text(
          //"Guapo",
           nombre,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Es un gusto tenerte por aquí",
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
  );
}

Widget botonCitas(BuildContext context) {
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
        MaterialPageRoute(builder: (context) => const CitasPage()),
      );
    },
    child: const Text("Citas", style: TextStyle(fontSize: 25.0)),
  );
}
