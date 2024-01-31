import 'package:flutter/material.dart';
import 'package:flutter_widgets_comarques/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.25,
                image: AssetImage("assets/images/travel_background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 240.0, // Ancho deseado
                      height: 113.0, // Altura deseada
                      child: Image.asset('assets/images/falomir_logo.png',
                          fit: BoxFit.cover),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      // Define el margen aquí
                      child: const Text(
                        'Les comarques de la comunitat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Blacklist',
                            fontWeight: FontWeight.bold,
                            color: Constants.myCustomColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      // Define el margen aquí
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Usuari",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      // Define el margen aquí
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Contrassenya",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
