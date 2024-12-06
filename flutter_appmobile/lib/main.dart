import 'package:flutter/material.dart';
import 'accueil.dart';
import 'shop.dart';
import 'map.dart';
import 'actu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Accueil(),
        '/shop': (context) => const Shop(),
        '/map': (context) => const Map(),
        '/actu': (context) => const Actu(),
      },
    );
  }
}
