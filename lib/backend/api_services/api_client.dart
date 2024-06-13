import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> updateInf(int cedula) async {
  var url =
      Uri.parse('http://192.168.10.4:3000/getUser'); // Cambiado para emulador

  try {
    // Enviar la solicitud POST con cedula y contrasenia en el cuerpo
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'documento': cedula.toString()}),
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

Future<Map<String, dynamic>> loginUser(String cedula, String contrasena) async {
  var url =
      Uri.parse('http://192.168.10.4:3000/login'); // Cambiado para emulador

  try {
    // Enviar la solicitud POST con cedula y contrasenia en el cuerpo
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'documento': cedula.toString(), 'contrasena': contrasena}),
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

Future<Map<String, dynamic>> registerUser(int cedula, String contrasena,
    String primnombre, String primapellido) async {
  var url = Uri.parse('http://192.168.10.4:3000/registerUser');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'Cedula': cedula,
      'Contrasena': contrasena,
      'PrimNombre': primnombre,
      'PrimApellido': primapellido,
    }),
  );

  // Verificar el estado de la respuesta
  if (response.statusCode == 200) {
    // Deserializar la respuesta JSON
    var responseBody = jsonDecode(response.body);
    return responseBody;
  } else if (response.statusCode == 409) {
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

