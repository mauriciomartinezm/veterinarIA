import 'package:flutter/material.dart';
import '../../api_services/api_cita.dart';
import '../../provider/userProvider.dart';
import 'package:provider/provider.dart';
import '../../api_services/api_pet.dart';

class CitasPage extends StatefulWidget {
  const CitasPage({super.key});

  @override
  State<CitasPage> createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
  List<Map<String, dynamic>> citas = [];
  List<Map<String, dynamic>> mascotas = [];
  List<Map<String, dynamic>> horarios = [];
  String? selectedMascota;
  String? selectedHorario;
  String motivo = '';

  late String cedula;

  void _agregarCita(String? mascota, String? horario, String motivo) async {
    String mascota2 = mascota ?? '';
    String horario2 = horario ?? '';

    var response = await registerCita(
        int.parse(mascota2), int.parse(horario2), cedula, motivo);
    var response2 = await updateHorario(int.parse(horario2), "Ocupado");
    await fetchHorarios();
    await fetchCitas();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      cedula = user?.cedula ?? '';
      await fetchPets();
      await fetchCitas();

      await fetchHorarios();
    });
  }

  String getNombreMascota(int id) {
    final mascota = mascotas.firstWhere((mascota) => mascota['id'] == id,
        orElse: () => {'nombre': 'Desconocido'});
    return mascota['nombre']!;
  }

  String getFechaHorario(int id) {
    final horario = horarios.firstWhere((horario) => horario['id'] == id,
        orElse: () => {'dia': 'Desconocido', 'hora': 'Desconocido'});
    return '${horario['dia']} - ${horario['hora']}';
  }

  Future<void> fetchCitas() async {
    try {
      var response = await getCitas(cedula);
      setState(() {
        citas = response.map((cita) {
          return {
            'id': cita['IDCita'],
            'IDMascota': cita['IDMascota'],
            'IDHorario': cita['IDHorario'],
            'motivo': cita['Observaciones'],
          };
        }).toList();
      });
    } catch (e) {
      print('Error al obtener mascotas: $e');
    }
  }

  Future<void> fetchHorarios() async {
    try {
      var response = await getHorarios();
      setState(() {
        horarios = response.map((horario) {
          return {
            'id': horario['id'],
            'dia': horario['dia'],
            'hora': horario['hora'],
            'estado': horario['estado'],

          };
        }).toList();
      });
    } catch (e) {
      print('Error al obtener mascotas: $e');
    }
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
              onPressed: () async {
                await deleteCita(citas[index]['id']);
                await updateHorario(citas[index]['IDHorario'], 'Libre');
                fetchHorarios();
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
        String? selectedMascotaId;
        String? selectedHorarioId;
        String motivo = '';

        return AlertDialog(
          title: const Text('Agendar Cita'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: selectedMascotaId,
                  hint: const Text('Seleccionar Mascota'),
                  items: mascotas.map((mascota) {
                    return DropdownMenuItem<String>(
                      value: mascota['id'].toString(),
                      child: Text(mascota['nombre']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedMascotaId = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedHorarioId,
                  hint: const Text('Seleccionar Horarioo'),
                  items: horarios
                      .where((horario) => horario['estado'] == 'Libre')
                      .map((horario) {
                    return DropdownMenuItem<String>(
                      value: horario['id'].toString(),
                      child: Text('${horario['dia']} - ${horario['hora']}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedHorarioId = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Motivo',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    motivo = value;
                  },
                ),
              ],
            ),
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
                if (selectedMascotaId != null &&
                    selectedHorarioId != null &&
                    motivo.isNotEmpty) {
                  _agregarCita(selectedMascotaId, selectedHorarioId, motivo);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, complete todos los campos.'),
                    ),
                  );
                }
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
                String nombreMascota =
                    getNombreMascota(citas[index]['IDMascota']!);
                String fechaHorario =
                    getFechaHorario(citas[index]['IDHorario']!);
                return ListTile(
                  title: Text('$nombreMascota - $fechaHorario',
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
