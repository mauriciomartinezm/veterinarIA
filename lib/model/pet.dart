class Pet {
  final int IDMascota;
  final String Nombre;
  final String CedulaPropietario;
  final int? IDEspecie;
  final int? IDFamilia;
  final int? IDGenero;
  final String? Fnacimiento;
  final int? IDSexo;
  final String FIngreso;
  final String? IDEstadoMasc;
  final String? FSalida;
  final String? IDTipoSalidaMasc;

  Pet({
    required this.IDMascota,
    required this.Nombre,
    required this.CedulaPropietario,
    required this.IDEspecie,
    required this.IDFamilia,
    required this.IDGenero,
    required this.Fnacimiento,
    required this.IDSexo,
    required this.FIngreso,
    this.IDEstadoMasc,
    this.FSalida,
    this.IDTipoSalidaMasc,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      IDMascota: json['IDMascota'],
      Nombre: json['Nombre'],
      CedulaPropietario: json['CedulaPropietario'],
      IDEspecie: json['IDEspecie'],
      IDFamilia: json['IDFamilia'],
      IDGenero: json['IDGenero'],
      Fnacimiento: json['Fnacimiento'],
      IDSexo: json['IDSexo'],
      FIngreso: json['FIngreso'],
      IDEstadoMasc: json['IDEstadoMasc'],
      FSalida: json['FSalida'],
      IDTipoSalidaMasc: json['IDTipoSalidaMasc'],
    );
  }
  @override
  String toJson() {
  return '''
  {
    "IDMascota": $IDMascota,
    "Nombre": "$Nombre",
    "CedulaPropietario": "$CedulaPropietario",
    "IDEspecie": $IDEspecie,
    "IDFamilia": $IDFamilia,
    "IDGenero": $IDGenero,
    "Fnacimiento": "$Fnacimiento",
    "IDSexo": $IDSexo,
    "FIngreso": "$FIngreso",
    "IDEstadoMasc": "$IDEstadoMasc",
    "FSalida": "$FSalida",
    "IDTipoSalidaMasc": "$IDTipoSalidaMasc"
  }
  ''';
}

}
