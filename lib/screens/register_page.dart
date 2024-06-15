import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/api_services/api_client.dart';
import 'package:prueba1/screens/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(BuildContext context) {
  TextEditingController cedulaController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
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
            campoCedula(cedulaController),
            campoNombre(nombreController),
            campoApellidos(apellidosController),
            campoContrasena(contrasenaController),
            botonRegistrar(context, cedulaController, nombreController,
                apellidosController, contrasenaController),
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

Widget campoCedula(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Cédula",
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
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

/*Widget campoCorreo(TextEditingController controller) {
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
}*/

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
    TextEditingController cedulaController,
    TextEditingController nombreController,
    TextEditingController apellidosController,
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
    onPressed: () async {
      String documento = cedulaController.text.trim();
      String nombre = nombreController.text.trim();
      String apellidos = apellidosController.text.trim();
      String contrasena = contrasenaController.text.trim();

      if (documento.isEmpty ||
          nombre.isEmpty ||
          apellidos.isEmpty ||
          contrasena.isEmpty) {
        // Verificar que todos los campos estén llenos
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todos los campos son obligatorios')),
        );
      } else if (contrasena.length < 3) {
        // Verificar que la contraseña tenga al menos 3 caracteres
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('La contraseña debe tener al menos 3 caracteres')),
        );
      } else {
        try {
          int cedula = int.parse(documento);
          var response =
              await registerUser(cedula, contrasena, nombre, apellidos);
          if (response.containsKey('messageSuccess')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Registro exitoso, por favor inicie sesión')),
            );
          } else if(response.containsKey('existingUser')){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("El usuario ya existe en el sistema")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('La cédula debe ser un número válido')),
          );
        }
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
