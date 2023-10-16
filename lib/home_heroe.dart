import 'package:api_movil_heroes/heroes_cards.dart';
import 'package:api_movil_heroes/heroes_datos.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HEROES API'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 400, // Altura total del contenedor
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dogy.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Center(
                      child: Image.asset(
                        'assets/dogy.png',
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 250,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Positioned(
                top: 25,
                left: 80,
                child: Text(
                  'HEROES SELECT',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text('Heroes'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => heroedatos()),
                      );
                    },
                    child: Text('Datos Del Heroe'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Coloca aquí la acción para el tercer botón.
                    },
                    child: Text('Habilidades'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
