import 'package:flutter/material.dart';

class InfoMascotaPage extends StatefulWidget {
  const InfoMascotaPage({super.key});

  @override
  State<InfoMascotaPage> createState() => _InfoMascotaPageState();
}

class _InfoMascotaPageState extends State<InfoMascotaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _especieController = TextEditingController();
  final _familiaController = TextEditingController();
  final _generoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _sexoController = TextEditingController();
  final _fechaIngresoController = TextEditingController();
  final _estadoController = TextEditingController();
  final _fechaSalidaController = TextEditingController();
  final _tipoSalidaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis mascotas',
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
            _buildTextFormField(_nombreController, 'Nombre'),
            _buildTextFormField(_especieController, 'Especie'),
            _buildTextFormField(_familiaController, 'Familia'),
            _buildTextFormField(_generoController, 'Genero'),
            _buildTextFormField(_fechaController, 'Fecha de nacimiento'),
            _buildTextFormField(_sexoController, 'Sexo'),
            _buildTextFormField(_fechaIngresoController, 'Fecha de ingreso'),
            _buildTextFormField(_estadoController, 'Estado'),
            _buildTextFormField(_fechaSalidaController, 'Fecha de salida'),
            _buildTextFormField(_tipoSalidaController, 'Tipo de salida'),
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
      child: const Text('Actualizar', style: TextStyle(fontSize: 18)),
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
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _sexoController.dispose();

    super.dispose();
  }
}
