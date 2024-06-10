import 'package:flutter/material.dart';

class InfoMascotaPage extends StatefulWidget {
  final String nombre;

  const InfoMascotaPage({super.key, required this.nombre});

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

  final List<String> opcionesFamilia = [
    "Serpientes",
    "Lagartos",
    "Tortugas",
    "Perros",
    "Gatos",
    "Ardillas",
    "Loros",
    "Pericos",
    "Patos",
  ];

  final List<String> opcionesEspecie = [
    "Mamiferos",
    "Aves",
    "Reptiles",
  ];

  final List<String> opcionesGenero = [
    "Viboras",
    "Tarentola",
    "Geochelone",
    "Canis",
    "Felis",
    "Scirius vulgaris",
    "Psittacoidea",
    "Melopsittacus undulatis",
    "Anas",
  ];

  final List<String> opcionesSexo = [
    "Masculino",
    "Femenino",
  ];

  String? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nombre de la mascota",
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
          child: Column(
            children: [
              _buildTextFormField(_nombreController, "Nombre", isRequired: true),
              _buildTextFormField(_fechaController, "Fecha de nacimiento"),
              _buildTextFormField(_fechaIngresoController, "Fecha de ingreso"),
              _buildTextFormField(_estadoController, "Estado"),
              _buildTextFormField(_fechaSalidaController, "Fecha de salida"),
              _buildTextFormField(_tipoSalidaController, "Tipo de salida"),
              especie(),
              familia(),
              genero(),
              sexo(),
              _buildImagePicker(),
              botonActualizar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Foto de la mascota",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            // No se como pero aqui va la logica para seleccionar la iamgen
          },
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _selectedImage == null
                  ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                  : Image.asset(_selectedImage!),
            ),
          ),
        ),
      ],
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
          // Aquí va la comunicación con esa mondá
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Información guardada")),
          );
        }
      },
      child: const Text("Actualizar", style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      {bool isPassword = false, bool isRequired = false}) {
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
          if (isRequired && (value == null || value.isEmpty)) {
            return "Por favor ingrese su $label";
          }
          return null;
        },
      ),
    );
  }

  Widget familia() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Familia",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
       
        value:
            _familiaController.text.isNotEmpty ? _familiaController.text : null,
        onChanged: (String? newValue) {
          setState(() {
            _familiaController.text = newValue ?? '';
          });
        },
        items: opcionesFamilia.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione una opción para la familia";
          }
          return null;
        },
      ),
    );
  }

  Widget especie() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Especie",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        value:
            _especieController.text.isNotEmpty ? _especieController.text : null,
        onChanged: (String? newValue) {
          setState(() {
            _especieController.text = newValue ?? '';
          });
        },
        items: opcionesEspecie.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione una opción para la especie";
          }
          return null;
        },
      ),
    );
  }

  Widget genero() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Género",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        value:
            _generoController.text.isNotEmpty ? _generoController.text : null,
        onChanged: (String? newValue) {
          setState(() {
            _generoController.text = newValue ?? '';
          });
        },
        items: opcionesGenero.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione una opción para el género";
          }
          return null;
        },
      ),
    );
  }

  Widget sexo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Sexo", //por favor
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        value: _sexoController.text.isNotEmpty ? _sexoController.text : null,
        onChanged: (String? newValue) {
          setState(() {
            _sexoController.text = newValue ?? '';
          });
        },
        items: opcionesSexo.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione una opción para el sexo";
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _especieController.dispose();
    _familiaController.dispose();
    _generoController.dispose();
    _fechaController.dispose();
    _sexoController.dispose();
    _fechaIngresoController.dispose();
    _estadoController.dispose();
    _fechaSalidaController.dispose();
    _tipoSalidaController.dispose();
    super.dispose();
  }
}
