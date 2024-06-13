import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> _fetchDepartamentos() async {
  final url = Uri.parse('https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries%2Bstates%2Bcities.json');
  //try {
  final response = await http.get(url);
  //if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return data;
  // } else {
  //  return data;
  //   throw Exception('Error al cargar los departamentos');
  //  }
  //} catch (e) {
  //   return data;
  // Manejar el error según tu aplicación
  // }
}

Future<void> _fetchMunicipios(String departamento) async {
  final url = Uri.parse('https://tu-api.com/municipios/$departamento');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar los municipios');
    }
  } catch (e) {
    print('Error: $e');
    // Manejar el error según tu aplicación
  }
}
