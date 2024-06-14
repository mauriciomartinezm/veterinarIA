class Pet {
  final int id;
  final String nombre;
  final String cedula;
  final int? especie;
  final int? familia;
  final int? genero;
  final String? fechaNacimiento;
  final int? sexo;
  final String fechaIngreso;
  final String? estado;
  final String? fechaSalida;
  final String? tipoSalida;

  Pet({
    required this.id,
    required this.nombre,
    required this.cedula,
    required this.especie,
    required this.familia,
    required this.genero,
    required this.fechaNacimiento,
    required this.sexo,
    required this.fechaIngreso,
    required this.estado,
    required this.fechaSalida,
    required this.tipoSalida,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['IDMascota'],
      nombre: json['Nombre'],
      cedula: json['CedulaPropietario'],
      especie: json['IDEspecie'],
      familia: json['IDFamilia'],
      genero: json['IDGenero'],
      fechaNacimiento: json['Fnacimiento'],
      sexo: json['IDSexo'],
      fechaIngreso: json['FIngreso'],
      estado: json['IDEstadoMasc'],
      fechaSalida: json['FSalida'],
      tipoSalida: json['IDTipoSalidaMasc'],
    );
  }
}
