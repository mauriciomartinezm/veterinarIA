import 'package:flutter/material.dart';
import 'info_mascota_page.dart'; // Importa la página de información de la mascota

class MascotasPage extends StatefulWidget {
  const MascotasPage({super.key});

  @override
  _MascotasPageState createState() => _MascotasPageState();
}

class _MascotasPageState extends State<MascotasPage> {
  List<String> mascotas = [];

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
        return AlertDialog(
          title: const Text("Agregar Mascota"),
          content: TextField(
            decoration: const InputDecoration(hintText: "Nombre de la mascota"),
            onSubmitted: (value) {
              _addMascota(value);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Mascotas'),
      ),
      body: ListView.builder(
        itemCount: mascotas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mascotas[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoMascotaPage(nombre: mascotas[index])),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeMascota(index),
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
