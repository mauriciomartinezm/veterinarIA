import 'package:flutter/material.dart';

class CitasPage extends StatefulWidget {
  const CitasPage({super.key});

  @override
  State<CitasPage> createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
  List<Map<String, String>> citas = [];

  void _agregarCita(String fecha, String hora, String motivo) {
    setState(() {
      citas.add({
        'fecha': fecha,
        'hora': hora,
        'motivo': motivo,
      });
    });
  }

  void _confirmarEliminarCita(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Eliminar Cita',
            style: TextStyle(
                color: Color.fromRGBO(221, 166, 101, 1),
                fontSize: 25.0,
                fontWeight: FontWeight.w700),
          ),
          content: const Text(
            '¿Estás seguro de que quieres eliminar esta cita?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Eliminar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                _eliminarCita(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _eliminarCita(int index) {
    setState(() {
      citas.removeAt(index);
    });
  }

  void _mostrarFormulario() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String fecha = '';
        String hora = '';
        String motivo = '';

        return AlertDialog(
          title: const Text('Agendar Cita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Fecha'),
                onChanged: (value) {
                  fecha = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Hora'),
                onChanged: (value) {
                  hora = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Motivo'),
                onChanged: (value) {
                  motivo = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () {
                _agregarCita(fecha, hora, motivo);
                Navigator.of(context).pop();
              },
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
          "Citas",
          style: TextStyle(
              color: Color.fromRGBO(221, 166, 101, 1),
              fontSize: 25.0,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
      ),
      body: cuerpo(),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormulario,
        backgroundColor: const Color.fromRGBO(221, 166, 101, 1),
        child: const Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget cuerpo() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/backgrounds/fondo_blanco.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: citas.isEmpty
          ? const Center(
              child: Text(
                'No tienes citas agendadas',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: citas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${citas[index]['fecha']} - ${citas[index]['hora']}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w700)),
                  subtitle: Text(citas[index]['motivo']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _confirmarEliminarCita(index);
                    },
                  ),
                );
              },
            ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CitasPage(),
  ));
}
