import 'package:flutter/material.dart';
import '../../api_services/api_pet.dart';
import '../../model/pet.dart';
import 'package:intl/intl.dart';

class InfoMascotaPage extends StatefulWidget {
  final int idMascota;
  const InfoMascotaPage({Key? key, required this.idMascota}) : super(key: key);

  @override
  State<InfoMascotaPage> createState() => _InfoMascotaPageState();
}

class _InfoMascotaPageState extends State<InfoMascotaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _fechaController = TextEditingController();
  final _fechaIngresoController = TextEditingController();
  final _estadoController = TextEditingController();
  final _fechaSalidaController = TextEditingController();
  final _tipoSalidaController = TextEditingController();
  String CedulaPropietario = '';
  int IDMascota = 0;
  String? _selectedEspecie;
  String? _selectedFamilia;
  String? _selectedGenero;
  String? _selectedSexo;

  final Map<String, int> mapOpcionesFamilia = {
    "Serpientes": 1,
    "Lagartos": 2,
    "Tortugas": 3,
    "Perros": 4,
    "Gatos": 5,
    "Ardillas": 6,
    "Loros": 7,
    "Pericos": 8,
    "Patos": 9,
  };

  final Map<String, int> mapOpcionesEspecie = {
    "Mamíferos": 1,
    "Aves": 2,
    "Reptiles": 3,
  };

  final Map<String, int> mapOpcionesGenero = {
    "Víboras": 1,
    "Tarentola": 2,
    "Geochelone": 3,
    "Canis": 4,
    "Felis": 5,
    "Scirius vulgaris": 6,
    "Psittacoidea": 7,
    "Melopsittacus undulatus": 8,
    "Anas": 9,
  };

  final Map<String, int> mapOpcionesSexo = {
    "Masculino": 1,
    "Femenino": 2,
  };

  @override
  void initState() {
    super.initState();
    _loadPetData();
  }

  Future<void> _loadPetData() async {
    try {
      Pet pet = await getPet(widget.idMascota);
      setState(() {
        IDMascota = pet.IDMascota;
        CedulaPropietario = pet.CedulaPropietario;
        _nombreController.text = pet.Nombre;
        _selectedEspecie = pet.IDEspecie != null ? mapOpcionesEspecie.entries
            .firstWhere((entry) => entry.value == pet.IDEspecie, orElse: () => MapEntry('', 0))
            .key : null;
        _selectedFamilia = pet.IDFamilia != null ? mapOpcionesFamilia.entries
            .firstWhere((entry) => entry.value == pet.IDFamilia, orElse: () => MapEntry('', 0))
            .key : null;
        _selectedGenero = pet.IDGenero != null ? mapOpcionesGenero.entries
            .firstWhere((entry) => entry.value == pet.IDGenero, orElse: () => MapEntry('', 0))
            .key : null;
        _selectedSexo = pet.IDSexo != null ? mapOpcionesSexo.entries
            .firstWhere((entry) => entry.value == pet.IDSexo, orElse: () => MapEntry('', 0))
            .key : null;

        _fechaController.text = pet.Fnacimiento ?? '';
        _fechaIngresoController.text = pet.FIngreso;
        _estadoController.text = pet.IDEstadoMasc ?? '';
        _fechaSalidaController.text = pet.FSalida ?? '';
        _tipoSalidaController.text = pet.IDTipoSalidaMasc ?? '';
      });
    } catch (e) {
      print('Error loading pet data: $e');
    }
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
            fontWeight: FontWeight.w700,
          ),
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
              _buildDateField(_fechaController, "Fecha de nacimiento"),
              _buildTextFormField(_fechaIngresoController, "Fecha de ingreso", isEnabled: false),
              _buildTextFormField(_estadoController, "Estado", isEnabled: false),
              _buildTextFormField(_fechaSalidaController, "Fecha de salida", isEnabled: false),
              _buildTextFormField(_tipoSalidaController, "Tipo de salida", isEnabled: false),
              especie(),
              familia(),
              genero(),
              sexo(),
              botonActualizar(context),
            ],
          ),
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
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // Crear un objeto Pet con los datos del formulario
          Pet updatedPet = Pet(
            IDMascota: IDMascota,
            Nombre: _nombreController.text,
            CedulaPropietario: CedulaPropietario,
            IDEspecie: mapOpcionesEspecie[_selectedEspecie] ?? 0,
            IDFamilia: mapOpcionesFamilia[_selectedFamilia] ?? 0,
            IDGenero: mapOpcionesGenero[_selectedGenero] ?? 0,
            Fnacimiento: _fechaController.text,
            IDSexo: mapOpcionesSexo[_selectedSexo] ?? 0,
            FIngreso: _fechaIngresoController.text,
            IDEstadoMasc: _estadoController.text,
            FSalida: _fechaSalidaController.text,
            IDTipoSalidaMasc: _tipoSalidaController.text,
          );
          try {
            // Llamar al subprograma updateUser con el ID de la mascota y el objeto Pet
            var response = await updateInf(IDMascota, updatedPet.toJson());

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Información actualizada")),
            );
          } catch (error) {
            print('Error al actualizar mascota: $error');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error al actualizar mascota")),
            );
          }
        }
      },
      child: const Text("Actualizar", style: TextStyle(fontSize: 12)),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      {bool isPassword = false, bool isRequired = false, bool isEnabled = true}) {
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
        enabled: isEnabled,
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now()
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              controller.text = formattedDate;
            });
          }
        },
      ),
    );
  }

  Widget especie() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: _selectedEspecie,
        items: mapOpcionesEspecie.keys.map((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(key),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedEspecie = value;
          });
        },
        decoration: InputDecoration(
          labelText: "Especie",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione una especie";
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
        value: _selectedFamilia,
        items: mapOpcionesFamilia.keys.map((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(key),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedFamilia = value;
          });
        },
        decoration: InputDecoration(
          labelText: "Familia",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione una familia";
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
        value: _selectedGenero,
        items: mapOpcionesGenero.keys.map((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(key),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedGenero = value;
          });
        },
        decoration: InputDecoration(
          labelText: "Género",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione un género";
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
        value: _selectedSexo,
        items: mapOpcionesSexo.keys.map((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(key),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedSexo = value;
          });
        },
        decoration: InputDecoration(
          labelText: "Sexo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor seleccione un sexo";
          }
          return null;
        },
      ),
    );
  }
}
