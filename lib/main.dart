import 'package:flutter/material.dart';
import 'package:flutter_widgets_comarques/comarcas.dart';
import 'package:flutter_widgets_comarques/infocomarca.dart';
import 'package:flutter_widgets_comarques/provincias.dart';
import 'package:flutter_widgets_comarques/homepage.dart';
import 'package:flutter_widgets_comarques/infoclima.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comarques',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Provincias(title: 'Les comarques de la comunitat'),
    );
  }
}








