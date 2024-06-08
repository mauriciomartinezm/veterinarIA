class User {
  final String cedula;
  final String contrasena;
  final String primnombre;
  final String segnombre;
  final String primapellido;
  final String segapellido;
  final int idsexo;
  final String direccion;
  final int idmunicipio;
  final int iddepto;
  final String celular;
  final String correoe;
  User(
      {required this.cedula,
      required this.contrasena,
      required this.primnombre,
      required this.segnombre,
      required this.primapellido,
      required this.segapellido,
      required this.idsexo,
      required this.direccion,
      required this.idmunicipio,
      required this.iddepto,
      required this.celular,
      required this.correoe});
}
