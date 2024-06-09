import 'package:flutter/material.dart';

class InfoUsuarioPage extends StatefulWidget {
  const InfoUsuarioPage({super.key});

  @override
  State<InfoUsuarioPage> createState() => _InfoUsuarioPageState();
}

class _InfoUsuarioPageState extends State<InfoUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _primerNombreController = TextEditingController();
  final _segundoNombreController = TextEditingController();
  final _primerApellidoController = TextEditingController();
  final _segundoApellidoController = TextEditingController();
  final _sexoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _municipioController = TextEditingController();
  final _departamentoController = TextEditingController();
  final _celularController = TextEditingController();
  final _correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mi información",
          style: TextStyle(
              color: Color.fromRGBO(221, 166, 101, 1),
              fontSize: 25.0,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
      ),
      body: cuerpo(context),
    );
  }

  Widget cuerpo(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/backgrounds/fondo_blanco.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            _buildTextFormField(_cedulaController, "Cédula"),
            _buildTextFormField(_contrasenaController, "Contraseña",
                isPassword: true),
            _buildTextFormField(_primerNombreController, "Primer Nombre"),
            _buildTextFormField(_segundoNombreController, 'Segundo Nombre'),
            _buildTextFormField(_primerApellidoController, 'Primer Apellido'),
            _buildTextFormField(_segundoApellidoController, 'Segundo Apellido'),
            _buildTextFormField(_sexoController, 'Sexo'),
            _buildTextFormField(_direccionController, 'Dirección'),
            _buildTextFormField(_municipioController, 'Municipio'),
            _buildTextFormField(_departamentoController, 'Departamento'),
            _buildTextFormField(_celularController, 'Celular'),
            _buildTextFormField(_correoController, 'Correo'),
            botonActualizar(context),
          ]),
        ),
      ),
    );
  }

  Widget botonActualizar(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 150),
        backgroundColor: const Color.fromRGBO(221, 166, 101, 1),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          //aqui va la comunicacion con la api Mauro
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Información guardada')),
          );
        }
      },
      child: const Text('Actualizar', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor ingrese su $label";
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _cedulaController.dispose();
    _contrasenaController.dispose();
    _primerNombreController.dispose();
    _segundoNombreController.dispose();
    _primerApellidoController.dispose();
    _segundoApellidoController.dispose();
    _sexoController.dispose();
    _direccionController.dispose();
    _municipioController.dispose();
    _departamentoController.dispose();
    _celularController.dispose();
    _correoController.dispose();
    super.dispose();
  }
}
