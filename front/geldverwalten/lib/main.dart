import 'package:flutter/material.dart';
import 'package:geldverwalten/pages/Accueil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeldVerwalten',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Accueil(title: 'GeldVerwalten'),
    );
  }
}
