import 'package:flutter/material.dart';
import 'package:flutter_widgets_comarques/main.dart';
import 'package:flutter_widgets_comarques/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'comarcas.dart';

class InfoClima extends StatefulWidget {
  const InfoClima({super.key, required this.title});

  final String title;

  @override
  State<InfoClima> createState() => _InfoClimaState();
}

class _InfoClimaState extends State<InfoClima> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.myCustomColor2,
          title: const Center(
            child: Text('La Safor',
                style: TextStyle(
                    color: Constants.myCustomColor,
                    fontFamily: 'Blacklist',
                    fontSize: 30)),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 50.0, bottom: 10),
                  height: 200.0,
                  width: 200.0,
                  child:
                      Image.asset('assets/images/aplicacion_meteorologica.png'),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.thermostat_sharp,
                          color: Constants.myCustomColor),
                      Text(
                        ' 19.5º',
                        style: TextStyle(
                            color: Constants.myCustomColor, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.wind_power_sharp,
                          color: Constants.myCustomColor),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '9.4km/h',
                          style: TextStyle(
                              color: Constants.myCustomColor, fontSize: 24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Ponent',
                          style: TextStyle(
                              color: Constants.myCustomColor, fontSize: 24),
                        ),
                      ),
                      Icon(Icons.arrow_back_sharp,
                          color: Constants.myCustomColor),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Comarca>>(
                    future: getComarcas('València'),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Comarca>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Població: ',
                                style: TextStyle(
                                    color: Constants.myCustomColor,
                                    fontSize: 24),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '${snapshot.data![Constants.idComarca].poblacio}',
                                style: const TextStyle(
                                    color: Constants.myCustomColor,
                                    fontSize: 24),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Comarca>>(
                    future: getComarcas('València'),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Comarca>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Latitud: ',
                                style: TextStyle(
                                    color: Constants.myCustomColor,
                                    fontSize: 24),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '${snapshot.data![Constants.idComarca].latitud}',
                                style: const TextStyle(
                                    color: Constants.myCustomColor,
                                    fontSize: 24),
                              ),
                            ),
                          ],
                        );
                      } // else
                    }, // builder
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Comarca>>(
                    future: getComarcas('València'),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Comarca>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Longitud: ',
                                style: TextStyle(
                                    color: Constants.myCustomColor,
                                    fontSize: 24),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '${snapshot.data![Constants.idComarca].longitud}',
                                style: const TextStyle(
                                    color: Constants.myCustomColor,
                                    fontSize: 24),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Container()
              ])),
        ));
  }
}

Future<List<Comarca>> getComarcas(String provincia) async {
  final response = await http.get(Uri.parse(
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques/$provincia'));

  if (response.statusCode == 200) {
    final List<String> comarcasList =
        List<String>.from(jsonDecode(response.body));
    List<Comarca> comarcas = [];

    for (String comarca in comarcasList) {
      final responseComarca = await http.get(Uri.parse(
          'https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca'));

      if (responseComarca.statusCode == 200) {
        comarcas.add(Comarca.fromJSON(jsonDecode(responseComarca.body)));
      } else {
        throw Exception('Failed to load comarca info');
      }
    }

    return comarcas;
  } else {
    throw Exception('Failed to load comarcas');
  }
}
