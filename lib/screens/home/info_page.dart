import 'package:flutter/material.dart';
import 'package:prueba1/screens/home/info_mascota_page.dart';
import '../../barra_inferior.dart';
import 'info_usuario_page.dart';

class InformacionPage extends StatelessWidget {
  const InformacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
      bottomNavigationBar:
          const MiBottomAppBar(disabledButton: 1), // Deshabilitar Información
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
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                info(),
                SizedBox(
                  width: 250,
                  height: 250,
                  child: botonMisMascotas(context),
                ),
                const SizedBox(height: 40), //Espacio entre los botones
                SizedBox(
                  width: 250,
                  height: 250,
                  child: botonMiInfo(context),
                ),
                // const SizedBox(height: 20), //Espacio entre los botones
                // SizedBox(
                //   width: 250, //tamaño botón
                //   child: botonNose(context),
                // ),
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
        MaterialPageRoute(builder: (context) => const InfoMascotaPage()),
      );
    },
    child: const Text("Mis mascotas",
        style: TextStyle(
          fontSize: 25.0,
        )),
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
    child: const Text("Mi información", style: TextStyle(fontSize: 25.0)),
  );
}
