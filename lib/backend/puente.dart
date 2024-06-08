import 'dart:convert';
import 'package:http/http.dart' as http;

/*Future<void> getUser(int cedula) async {
  var url = Uri.parse('http://192.168.10.4:3000/usuario');

  // Enviar la solicitud POST con cedula y contrasenia en el cuerpo
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'documento': cedula}),
  );
}*/

Future<Map<String, dynamic>> loginUser(int cedula, String contrasena) async {
  var url =
      Uri.parse('http://192.168.10.4:3000/login'); // Cambiado para emulador

  try {
    // Enviar la solicitud POST con cedula y contrasenia en el cuerpo
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'documento': cedula.toString(), 'contrasena': contrasena}),
    );

    // Verificar el estado de la respuesta
    if (response.statusCode == 200) {
      // Deserializar la respuesta JSON
      var responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      // Manejar el error devolviendo la respuesta JSON con un mensaje de error
      var responseBody = jsonDecode(response.body);
      return responseBody;
    }
  } catch (e) {
    print('Error al hacer la solicitud: $e');
    return {'messageFail': 'Error de conexión'};
  }
}

void getUsers() async {
  var url = Uri.parse('http://192.168.10.4:3000/getUsers');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseBody = response.body;
    print(responseBody);
  } else {
    print('Error en la petición: ${response.statusCode}');
  }
}

Future<bool> registrarUsuario(
    String cedula,
    String contrasena,
    String primnombre,
    String segnombre,
    String primapellido,
    String segmapellido,
    int idsexo,
    String direccion,
    int idmunicipio,
    int iddepto,
    String celular) async {
  var url = Uri.parse('http://192.168.56.1:3000/registerUser');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'Cedula': cedula,
      'Contrasena': contrasena,
      'PrimNombre': primnombre,
      'SegNombre': segnombre,
      'PrimApellido': primapellido,
      'SegApellido': segmapellido,
      'IDSexo': idsexo,
      'direccion': direccion,
      'IDMunicipio': idmunicipio,
      'IDDepto': iddepto,
      'TelCel': celular
    }),
  );

  // Verificar el estado de la respuesta
  if (response.statusCode == 200) {
    // Deserializar la respuesta JSON
    var responseBody = jsonDecode(response.body);
    return responseBody;
  } else {
    // Manejar el error devolviendo la respuesta JSON con un mensaje de error
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }
}
/*void verificarCuenta() async {
  var response = await http.get(
    Uri.parse('http://localhost:3000/usuarios'),
    headers: {'Content-Type': 'application/json'},
    //body: jsonEncode({'IDUsuario': cedula}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['exists'];
  } else {
    throw Exception('Error al verificar cuenta');
  }
}

Future<void> fetchUsuarios() async {
  final response = await http.get(Uri.parse('http://localhost:3000/usuarios'));

  if (response.statusCode == 200) {
    // La solicitud fue exitosa
    final Map<String, dynamic> data = json.decode(response.body);
    print(data); // Aquí puedes manejar la respuesta JSON como desees
  } else {
    // Si la solicitud no fue exitosa, maneja el error
    print('Error al obtener usuarios: ${response.reasonPhrase}');
  }
}*/

