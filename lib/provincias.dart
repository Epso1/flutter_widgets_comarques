import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'comarcas.dart';

const double circleSize = 215;

class Provincias extends StatefulWidget {
  const Provincias({super.key, required this.title});

  final String title;

  @override
  State<Provincias> createState() => _ProvinciasState();
}

class _ProvinciasState extends State<Provincias> {
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50.0, bottom: 10),
              width: circleSize,
              height: circleSize,
              child: FutureBuilder<Provincia>(
                future: getProvincia('Castelló'),
                builder:
                    (BuildContext context, AsyncSnapshot<Provincia> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Comarcas(
                                    title: 'Comarques de Castelló')),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.img),
                              minRadius: circleSize,
                            ),
                            Text(
                              snapshot.data!.provincia,
                              style: const TextStyle(
                                fontFamily: 'Blacklist',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  } // else
                }, // builder
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              width: circleSize,
              height: circleSize,
              child: FutureBuilder<Provincia>(
                future: getProvincia('València'),
                builder:
                    (BuildContext context, AsyncSnapshot<Provincia> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!.img),
                          minRadius: circleSize,
                        ),
                        Text(
                          snapshot.data!.provincia,
                          style: const TextStyle(
                            fontFamily: 'Blacklist',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } // else
                }, // builder
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 50),
              width: circleSize,
              height: circleSize,
              child: FutureBuilder<Provincia>(
                future: getProvincia('Alacant'),
                builder:
                    (BuildContext context, AsyncSnapshot<Provincia> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!.img),
                          minRadius: circleSize,
                        ),
                        Text(
                          snapshot.data!.provincia,
                          style: const TextStyle(
                            fontFamily: 'Blacklist',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } // else
                }, // builder
              ),
            ),
            Container()
          ],
        ),
      ),
    ));
  }
}

Future<String> getProvinciaImage(String provincia) async {
  final response = await http.get(Uri.parse(
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques/'));

  if (response.statusCode == 200) {
    List<dynamic> provincias = jsonDecode(response.body);
    for (var provinciaData in provincias) {
      if (provinciaData['provincia'] == provincia) {
        return provinciaData['img'];
      }
    }
    return 'No se ha encontrado la provincia';
  } else {
    throw Exception('Error: Código de respuesta: ${response.statusCode}');
  }
}

// Crea un método getProvincia() para que reciba el nombre de la provincia y devuelva el campo provincia de la provincia
// que coincida con el nombre recibido
Future<Provincia> getProvincia(String provincia) async {
  final response = await http.get(Uri.parse(
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques/'));

  if (response.statusCode == 200) {
    List<dynamic> provincias = jsonDecode(response.body);
    for (var provinciaData in provincias) {
      if (provinciaData['provincia'] == provincia) {
        return Provincia.fromJson(provinciaData);
      }
    }
    throw Exception('No se ha encontrado la provincia');
  } else {
    throw Exception('Error: Código de respuesta: ${response.statusCode}');
  }
}

Future<List<Provincia>> getProvincias() async {
  final response = await http.get(Uri.parse(
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques/'));

  if (response.statusCode == 200) {
    List<dynamic> provincias = jsonDecode(response.body);
    List<Provincia> provinciasList = [];

    for (var provinciaData in provincias) {
      provinciasList.add(Provincia.fromJson(provinciaData));
    }

    return provinciasList;
  } else {
    throw Exception('Error: Código de respuesta: ${response.statusCode}');
  }
}

class Provincia {
  final String provincia;
  final String img;

  Provincia({required this.provincia, required this.img});

  String get getProvincia => provincia;

  String get getImg => img;

  factory Provincia.fromJson(Map<String, dynamic> json) {
    return Provincia(
      provincia: json['provincia'],
      img: json['img'],
    );
  }

  @override
  String toString() {
    return provincia;
  }
}
