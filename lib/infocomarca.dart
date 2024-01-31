import 'package:flutter/material.dart';
import 'package:flutter_widgets_comarques/main.dart';
import 'package:flutter_widgets_comarques/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InfoComarca extends StatefulWidget {
  const InfoComarca({super.key, required this.title});

  final String title;

  @override
  State<InfoComarca> createState() => _InfoComarcaState();
}

class _InfoComarcaState extends State<InfoComarca> {
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
                  margin: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: FutureBuilder<List<Comarca>>(
                        future: getComarcas('València'),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Comarca>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Column(
                              children: <Widget>[
                                Ink.image(
                                  image: NetworkImage(
                                      snapshot.data![Constants.idComarca].img ??
                                          ''),
                                  fit: BoxFit.cover,
                                  height: 225.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data![Constants.idComarca].comarca,
                                    style: const TextStyle(
                                        color: Constants.myCustomColor,
                                        fontSize: 40),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Capital: ${snapshot.data![Constants.idComarca].capital}' ??
                                          '',
                                      style: const TextStyle(
                                          color: Constants.myCustomColor,
                                          fontSize: 30)),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      snapshot.data![Constants.idComarca]
                                              .desc ??
                                          '',
                                      style: const TextStyle(
                                          color: Constants.myCustomColor,
                                          fontSize: 16)),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
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

class Comarca {
  String comarca;
  String? capital;
  String? poblacio;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;

  Comarca(this.comarca,
      {this.capital,
      this.poblacio,
      this.img,
      this.desc,
      this.latitud,
      this.longitud});

  Comarca.fromJSON(Map<String, dynamic> json)
      : comarca = json['comarca'],
        capital = json['capital'],
        poblacio = json['poblacio '],
        img = json['img'],
        desc = json['desc'],
        latitud = json['latitud'],
        longitud = json['longitud'];

  @override
  String toString() {
    return '''
    nombre: $comarca
    capital: ${capital ?? 'N/A'}
    población: ${poblacio ?? 'N/A'}
    imagen: ${img ?? 'N/A'}
    descripción: ${desc ?? 'N/A'}
    coordenadas: (${latitud ?? 'N/A'}, ${longitud ?? 'N/A'})
    ''';
  }
}
