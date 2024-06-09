import 'package:flutter/material.dart';
import '../../barra_inferior.dart';
import '../../provider/userProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
      bottomNavigationBar:
          const MiBottomAppBar(disabledButton: 2), //Deshabilita el Home
    );
  }
}

Widget cuerpo(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      // gradient: LinearGradient(
      //   colors: [
      //     Color.fromRGBO(221, 166, 101, 1),
      //     Color.fromRGBO(161, 108, 44, 1),
      //   ],
      //   begin: Alignment.topRight,
      //   end: Alignment.bottomLeft,
      // ),
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
                  width: 250, //tamaño botón
                  child: botonCitas(context),
                ),
                const SizedBox(height: 20), //Espacio entre los botones
                SizedBox(
                  width: 250, // tamaño botón
                  child: botonMascotas(context),
                ),
                const SizedBox(height: 20), //Espacio entre los botones
                SizedBox(
                  width: 250, //tamaño botón
                  child: botonNose(context),
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
        const FotoPerfil(),
        saludo(context),
      ],
    ),
  );
}

class FotoPerfil extends StatelessWidget {
  const FotoPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      left: 30,
      top: 70,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
          "https://i.pinimg.com/474x/31/ec/2c/31ec2ce212492e600b8de27f38846ed7.jpg",
        ),
      ),
    );
  }
}

Widget saludo(BuildContext context) {
  var userProvider = Provider.of<UserProvider>(context);
  var user = userProvider.user;
  String nombre = user!.primnombre;

  return Positioned(
    left: 160,
    top: 75,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hola,",
          style: TextStyle(fontSize: 25),
        ),
        Text(
          //"nombre",
          nombre,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
    onPressed: () {},
    child: const Text("Citas", style: TextStyle(fontSize: 25.0)),
  );
}

Widget botonMascotas(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 25),
      backgroundColor: const Color.fromARGB(255, 153, 111, 63),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    onPressed: () {},
    child: const Text("Mascotas", style: TextStyle(fontSize: 25.0)),
  );
}

Widget botonNose(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 25),
      backgroundColor: const Color.fromARGB(255, 153, 111, 63),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    onPressed: () {},
    child:
        const Text("Cancelemos esta mondá", style: TextStyle(fontSize: 17.0)),
  );
}
