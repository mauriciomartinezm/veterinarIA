import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/provider/userProvider.dart';
import "screens/login_page.dart";
import 'screens/register_page.dart';
import 'screens/home/home_page.dart';
import 'screens/home/info_page.dart';
import 'screens/home/info_usuario_page.dart';
import 'screens/home/info_mascota_page.dart';
import './screens/home/citas_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Miapp(),
    ),
  );
}

class Miapp extends StatelessWidget {
  Miapp({super.key});

  final _routes = {
    'login': (_) => const LoginPage(),
    'register': (_) => const RegisterPage(),
    'home': (_) => const HomePage(),
    'informacion': (_) => const InformacionPage(),
    'infoUsuario': (_) => const InfoUsuarioPage(),
    'infoMascotas': (_) => const InfoMascotaPage(idMascota: 1,), //? ? ?? ? ? ? 
    'citas': (_) => const CitasPage(),

  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mi app",
      routes: _routes,
      initialRoute: 'home'
      ,
    );
  }
}
