import 'package:flutter/material.dart';
import 'package:prueba1/screens/login_page.dart';
import 'screens/home/info_page.dart';
import 'screens/home/home_page.dart';

class MiBottomAppBar extends StatelessWidget {
  final int disabledButton;

  const MiBottomAppBar({super.key, this.disabledButton = 0});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Color.fromARGB(255, 221, 166, 101),
              size: 30.0,
            ),
            onPressed: disabledButton != 1
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InformacionPage()),
                    );
                  }
                : null, //Deshabilita  informacion si disabledButton es igual a 1
          ),
          IconButton(
            icon: const Icon(
              Icons.home_filled,
              color: Color.fromARGB(255, 221, 166, 101),
              size: 30.0,
            ),
            onPressed: disabledButton != 2
                ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                : null, //Deshabilita el home si disabledButton es igual a 2
          ),
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Color.fromARGB(255, 221, 166, 101),
              size: 30.0,
            ),
            onPressed: disabledButton != 3
                ? () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Despidete bien",
                            style: TextStyle(
                                color: Color.fromRGBO(221, 166, 101, 1),
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700),
                          ),
                          content: const Text("¿Salir de tu cuenta?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                "Cancelar",
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
                                "Salir",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Cerraste sesión")),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                : null, //Deshabilita l si disabledButton es igual a 3
          ),
        ],
      ),
    );
  }
}
