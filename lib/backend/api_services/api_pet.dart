import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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

void getPets() async {
  var url = Uri.parse('http://192.168.10.4:3000/getPets');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseBody = response.body;
    print(responseBody);
  } else {
    print('Error en la petición: ${response.statusCode}');
  }
}

Future<Map<String, dynamic>> registerPet(String nombre, String cedula) async {
  var url = Uri.parse('http://192.168.10.4:3000/registerPet');
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);

  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'Nombre': nombre,
      'CedulaPropietario': cedula,
      'FIngreso': formattedDate,
    }),
  );
  var responseBody = jsonDecode(response.body);

  // Verificar el estado de la respuesta
  if (response.statusCode == 200) {
    // Deserializar la respuesta JSON
    return responseBody;
  } else if (response.statusCode == 409) {
    return responseBody;
  } else {
    // Manejar el error devolviendo la respuesta JSON con un mensaje de error
    return responseBody;
  }
}
