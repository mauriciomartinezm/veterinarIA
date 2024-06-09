import 'package:flutter/material.dart';
import 'package:prueba1/screens/home/mascotas_page.dart';
import '../../barra_inferior.dart';
import 'info_usuario_page.dart';

class InformacionPage extends StatelessWidget {
  const InformacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
      bottomNavigationBar: const MiBottomAppBar(disabledButton: 1), // Deshabilitar Información
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
        const SizedBox(height: 100), //Espacio superior
        info(),
        const SizedBox(height: 50), //Espacio entre el título y los botones
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botonMisMascotas(context),
                const SizedBox(height: 40), //Espacio entre los botones
                botonMiInfo(context),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget info() {
  return const Text(
    "Información",
    style: TextStyle(
        color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w700),
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
