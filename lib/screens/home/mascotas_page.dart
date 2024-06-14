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
  List<Map<String, dynamic>> mascotas = [];

  late String cedula;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      cedula = user?.cedula ?? '';

      await fetchPets();
    });
  }

  Future<void> fetchPets() async {
    try {
      var pets = await getPets(cedula);
      setState(() {
        mascotas = pets.map((pet) {
          return {
            'id': pet['IDMascota'],
            'nombre': pet['Nombre'],
          };
        }).toList();
      });
    } catch (e) {
      print('Error al obtener mascotas: $e');
    }
  }

  void _addMascota(String nombre, int id) {
    try {
      setState(() {
        mascotas.add({
          'id': id,
          'nombre': nombre,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mascota agregada")),
      );

      Navigator.pop(context); // Cierra el diálogo de agregar mascota
    } catch (error) {
      print('Error al agregar mascota: $error');
      setState(() {
        //_errorMessage = 'Error al agregar la mascota';
      });
    }
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
        // Obtener el ID de la mascota seleccionada
        int mascotaId = mascotas[index]['id'];

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
              onPressed: () async {
                var response =
                    await deletePet(mascotaId); // Enviar el ID a deletePet
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
            title: Text(mascotas[index]['nombre']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoMascotaPage(
                    IDMascota: mascotas[index]['id'],
                  ),
                ),
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
  final Function(String, int) addMascota;
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
      print("hola");
      var response = await registerPet(nombre, widget.cedula);

      if (response.containsKey('existingPet')) {
        setState(() {
          _errorMessage = 'Ya existe una mascota con ese nombre';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mascota agregada")),
        );
        print(response['id']);
        widget.addMascota(nombre, response['id']);
        //Navigator.pop(context);
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
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _handleAdd,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
