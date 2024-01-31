import 'package:flutter/material.dart';
import 'package:flutter_widgets_comarques/main.dart';
import 'package:flutter_widgets_comarques/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Comarcas extends StatefulWidget {
  const Comarcas({super.key, required this.title});

  final String title;

  @override
  State<Comarcas> createState() => _ComarcasState();
}

class _ComarcasState extends State<Comarcas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.myCustomColor2,
        title: const Text(
            'Comarques de València',
            style: TextStyle(color:Constants.myCustomColor,
                fontFamily: 'Blacklist',
                fontSize: 30)
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.25,
            image: AssetImage("assets/images/travel_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
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
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {

                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                Ink.image(
                                  image: NetworkImage(
                                      snapshot.data![index].img ?? ''),
                                  fit: BoxFit.cover,
                                  height: 150.0,

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    snapshot.data![index].comarca,
                                    style: const TextStyle(
                                      fontFamily: 'Blacklist',
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
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
        poblacio = json['poblacio'],
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
