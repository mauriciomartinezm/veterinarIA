import 'package:flutter/material.dart';
import 'info_mascota_page.dart'; // Importa la página de información de la mascota
import '../../backend/api_services/api_pet.dart';
import 'package:provider/provider.dart';
import '../../provider/userProvider.dart';

class MascotasPage extends StatefulWidget {
  const MascotasPage({super.key});

  @override
  _MascotasPageState createState() => _MascotasPageState();
}

class _MascotasPageState extends State<MascotasPage> {
  List<String> mascotas = [];
  late String cedula;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    cedula = user?.cedula ?? '';
  }

  void _addMascota(String nombre) {
    setState(() {
      mascotas.add(nombre);
    });
  }

  void _removeMascota(int index) {
    setState(() {
      mascotas.removeAt(index);
    });
  }

  void _showAddMascotaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddMascotaDialog(addMascota: _addMascota, cedula: cedula);
      },
    );
  }

  void _showRemoveMascotaDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar Mascota"),
          content:
              const Text("¿Estás seguro de que deseas eliminar esta mascota?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _removeMascota(index);
                Navigator.pop(context);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mis mascotas",
          style: TextStyle(
              color: Color.fromRGBO(221, 166, 101, 1),
              fontSize: 25.0,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: mascotas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mascotas[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InfoMascotaPage(nombre: mascotas[index])),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showRemoveMascotaDialog(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMascotaDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddMascotaDialog extends StatefulWidget {
  final Function(String) addMascota;
  final String cedula;

  const AddMascotaDialog({required this.addMascota, required this.cedula});

  @override
  _AddMascotaDialogState createState() => _AddMascotaDialogState();
}

class _AddMascotaDialogState extends State<AddMascotaDialog> {
  final TextEditingController _controller = TextEditingController();
  String _errorMessage = '';

  Future<void> _handleAdd() async {
    final nombre = _controller.text.trim();
    if (nombre.isEmpty) {
      setState(() {
        _errorMessage = 'Ingrese el nombre de la mascota';
      });
    } else {
      var response = await registerPet(nombre, widget.cedula);
      if (response.containsKey('existingPet')) {
        setState(() {
          _errorMessage = 'Ya existe una mascota con ese nombre';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mascota agregada")),
        );
        widget.addMascota(nombre);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Agregar Mascota"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Nombre de la mascota"),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _handleAdd,
          child: const Text('Agregar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
