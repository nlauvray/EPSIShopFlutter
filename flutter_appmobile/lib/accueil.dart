import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 172, 90, 30), // Couleur de fond de l'AppBar
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shop),
              onPressed: () {
                Navigator.pushNamed(context, '/shop');
              },
            ),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
            ),
            IconButton(
              icon: const Icon(Icons.article),
              onPressed: () {
                Navigator.pushNamed(context, '/actu');
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255), // Couleur de fond du body
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ajout du logo
              Image.asset(
                'assets/logo.jpg',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Bienvenue sur notre site !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/shop');
                },
                child: const Text('Aller à la boutique'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}