import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/userProvider.dart';
import 'dart:convert';
import '../../model/user.dart';
import 'package:http/http.dart' as http;
import '../../api_services/api_client.dart';

class InfoUsuarioPage extends StatefulWidget {
  const InfoUsuarioPage({Key? key}) : super(key: key);

  @override
  State<InfoUsuarioPage> createState() => _InfoUsuarioPageState();
}

class _InfoUsuarioPageState extends State<InfoUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cedulaController;
  late TextEditingController _contrasenaController;
  late TextEditingController _primerNombreController;
  late TextEditingController _segundoNombreController;
  late TextEditingController _primerApellidoController;
  late TextEditingController _segundoApellidoController;
  late TextEditingController _sexoController;
  late TextEditingController _direccionController;
  late TextEditingController _departamentoController;
  late TextEditingController _municipioController;
  late TextEditingController _celularController;
  late TextEditingController _correoController;
  List<String> departamentos = [];
  List<String> municipios = [];
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    _cedulaController = TextEditingController(text: user?.cedula ?? '');
    _contrasenaController = TextEditingController(text: user?.contrasena ?? '');
    _primerNombreController =
        TextEditingController(text: user?.primnombre ?? '');
    _segundoNombreController =
        TextEditingController(text: user?.segnombre ?? '');
    _primerApellidoController =
        TextEditingController(text: user?.primapellido ?? '');
    _segundoApellidoController =
        TextEditingController(text: user?.segapellido ?? '');
    _sexoController =
        TextEditingController(text: user?.idsexo.toString() ?? '');
    _direccionController = TextEditingController(text: user?.direccion ?? '');
    _departamentoController =
        TextEditingController(text: user?.departamento ?? '');
    _municipioController = TextEditingController(text: user?.municipio ?? '');
    _celularController = TextEditingController(text: user?.celular ?? '');
    _correoController = TextEditingController(text: user?.correoe ?? '');

    _fetchDepartamentos().then((_) {
      if (user?.departamento != null) {
        _departamentoController.text = user!.departamento;
        _fetchMunicipios(user.departamento).then((_) {
          setState(() {
            _municipioController.text = user.municipio;
          });
        });
      }
    });
  }

  Future<void> _fetchDepartamentos() async {
    try {
      var url = Uri.parse(
          'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries%2Bstates%2Bcities.json');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var pais = data.firstWhere((item) => item['name'] == 'Colombia',
            orElse: () => null);

        if (pais != null) {
          List<String> departamentos = (pais['states'] as List)
              .map<String>((state) => state['name'] as String)
              .where((name) =>
                  name != 'Bogotá D.C.') // Filtro para eliminar Bogotá D.C.
              .toList();
          setState(() {
            this.departamentos = departamentos;
          });
          print(departamentos);
        } else {
          print(
              'No se encontró información sobre los departamentos de Colombia');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al cargar los departamentos: $error');
    }
  }

  Future<void> _fetchMunicipios(String departamentoSeleccionado) async {
    try {
      var url = Uri.parse(
          'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries%2Bstates%2Bcities.json');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List<dynamic>;

        var departamento = data
            .map((country) => country['states'])
            .expand((states) => states)
            .firstWhere((state) => state['name'] == departamentoSeleccionado,
                orElse: () => null);

        if (departamento != null) {
          List<String> municipios = (departamento['cities'] as List)
              .map<String>((city) => city['name'] as String)
              .toList();

          setState(() {
            // Limpiar la lista de municipios antes de actualizar
            this.municipios.clear();
            this.municipios.addAll(municipios);

            // Actualizar el valor seleccionado del municipio si es necesario
            if (!municipios.contains(_municipioController.text)) {
              _municipioController.text = '';
            }
          });
        } else {
          print(
              'No se encontró información sobre los municipios de $departamentoSeleccionado');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al cargar los municipios: $error');
    }
  }

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
            _buildTextFormField(_cedulaController, "Cédula", isEnabled: false),
            _buildPasswordFormField(_contrasenaController, "Contraseña"),
            _buildTextFormField(_primerNombreController, "Primer Nombre"),
            _buildTextFormField(_segundoNombreController, 'Segundo Nombre',
                isOptional: true),
            _buildTextFormField(_primerApellidoController, 'Primer Apellido'),
            _buildTextFormField(_segundoApellidoController, 'Segundo Apellido'),
            _buildDropdownField(_sexoController, 'Sexo',
                ['Masculino', 'Femenino', '39 tipos de gay'], (value) {}),
            _buildTextFormField(_direccionController, 'Dirección'),
            _buildDropdownField(
                _departamentoController, "Departamento", departamentos,
                (value) {
              _fetchMunicipios(value);
            }),
            _buildDropdownField(
                _municipioController, "Municipio", municipios, (value) {}),
            _buildTextFormField(_celularController, 'Celular',
                keyboardType: TextInputType.number),
            _buildTextFormField(_correoController, 'Correo',
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator),
            botonActualizar(context),
          ]),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      {bool isPassword = false,
      bool isEnabled = true,
      bool isOptional = false,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        enabled: isEnabled,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                if (isOptional) {
                  return null;
                }
                return "Por favor ingrese su $label";
              }
              return null;
            },
      ),
    );
  }

  Widget _buildPasswordFormField(
      TextEditingController controller, String label) {
    return _buildTextFormField(controller, label, isPassword: true);
  }

  Widget _buildDropdownField(TextEditingController controller, String label,
      List<String> items, Function(String) onChanged) {
    String? selectedValue =
        items.contains(controller.text) ? controller.text : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            controller.text = value!;
          });
          onChanged(
              value!); // Llamar a la función onChanged con el valor seleccionado
        },
        items: items.map((item) {
          String displayText =
              item.length > 20 ? item.substring(0, 20) + '...' : item;
          return DropdownMenuItem<String>(
            value: item,
            child: Text(displayText),
          );
        }).toList(),
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
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          final user = userProvider.user;

          var response = await updateInf(
            user?.cedula,
            _contrasenaController.text,
            _primerNombreController.text,
            _segundoNombreController.text,
            _primerApellidoController.text,
            _segundoApellidoController.text,
            _sexoController.text,
            _direccionController.text,
            _municipioController.text,
            _departamentoController.text,
            _celularController.text,
            _correoController.text,
          );

          var user2 = User(
            cedula: response['propietario']['CedulaPropietario'],
            contrasena: response['propietario']['Contrasena'],
            primnombre: response['propietario']['PrimNombre'],
            segnombre: response['propietario']['SegNombre'],
            primapellido: response['propietario']['PrimApellido'],
            segapellido: response['propietario']['SegApellido'],
            idsexo: response['propietario']['IDSexo'],
            direccion: response['propietario']['Direccion'],
            municipio: response['propietario']['Municipio'],
            departamento: response['propietario']['Departamento'],
            celular: response['propietario']['TelCel'],
            correoe: response['propietario']['CorreoE'],
          );

          userProvider.login(user2);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Información guardada')),
          );
        }
      },
      child: const Text('Actualizar', style: TextStyle(fontSize: 16)),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su Correo';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor ingrese un correo válido';
    }
    return null;
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
    _departamentoController.dispose();
    _municipioController.dispose();
    _celularController.dispose();
    _correoController.dispose();
    super.dispose();
  }
}
