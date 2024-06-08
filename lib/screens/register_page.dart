import 'package:flutter/material.dart';
//import 'package:prueba1/backend/puente.dart';
import 'package:prueba1/screens/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(BuildContext context) {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();

  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/backgrounds/fondo_cafe.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo(),
            crea(),
            campoNombre(nombreController),
            campoApellidos(apellidosController),
            campoCorreo(correoController),
            campoContrasena(contrasenaController),
            botonRegistrar(context, nombreController, apellidosController,
                correoController, contrasenaController),
            tengo(context)
          ],
        ),
      ),
    ),
  );
}

Widget logo() {
  return Column(
    children: [
      Image.asset(
        "assets/images/logoMini_negro.png",
        width: 150,
        height: 150,
      ),
    ],
  );
}

Widget crea() {
  return const Text(
    "Crea tu cuenta",
    style: TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700),
  );
}

Widget campoNombre(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Nombre",
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: const Icon(Icons.person),
      ),
    ),
  );
}

Widget campoApellidos(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Apellidos",
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: const Icon(Icons.person_outline),
      ),
    ),
  );
}

Widget campoCorreo(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Correo",
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
    ),
  );
}

Widget campoContrasena(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
    child: TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Contraseña",
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: const Icon(Icons.lock),
      ),
    ),
  );
}

Widget botonRegistrar(
    BuildContext context,
    TextEditingController nombreController,
    TextEditingController apellidosController,
    TextEditingController correoController,
    TextEditingController contrasenaController) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      backgroundColor: const Color.fromARGB(255, 221, 166, 101),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Colors.white, width: 2.0),
      ),
    ),
    onPressed: () async{
      String nombre = nombreController.text;
      String apellidos = apellidosController.text;
      String correo = correoController.text;
      String contrasena = contrasenaController.text;
      
      //await getUser(1001153936);      

      if (nombre.isEmpty ||
          apellidos.isEmpty ||
          correo.isEmpty ||
          contrasena.isEmpty) {
        // Verificar que todos los campos estén llenos
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todos los campos son obligatorios')),
        );
      } else if (contrasena.length < 3) {
        // Verificar que la contraseña tenga al menos 3 caracteres
                ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La contraseña debe tener al menos 3 caracteres')),
        );
      } else {
        // Realizar el registro aquí
        // Por ejemplo, puedes enviar los datos a una API
        // Una vez registrado, puedes navegar a la página de inicio de sesión
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    },
    child: const Text("Registrarse", style: TextStyle(fontSize: 17.0)),
  );
}

Widget tengo(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 70.0),
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(198, 255, 255, 255),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: const Text("Tengo una cuenta"),
    ),
  );
}

