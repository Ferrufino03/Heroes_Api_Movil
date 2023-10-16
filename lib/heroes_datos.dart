import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Models/heroes.dart';

class heroedatos extends StatefulWidget {
  const heroedatos({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<heroedatos> {
  HeroeDatos? heroeDatos;
  TextEditingController searchController =
      TextEditingController(); // Controlador para el campo de búsqueda.

  @override
  void initState() {
    super.initState();
  }

  Future<void> searchHeroe(String searchTerm) async {
    final response = await Dio().get(
        'https://www.superheroapi.com/api.php/1004803797442789/search/$searchTerm');

    if (response.statusCode == 200) {
      final List<dynamic> results = response.data["results"];

      if (results.isNotEmpty) {
        final Map<String, dynamic> firstResult = results.first;
        final String id = firstResult["id"];
        final String name = firstResult["name"];
        final String imageUrl = firstResult["image"]["url"];

        // Obtener los datos adicionales de la API
        final responseDatos = await Dio().get(
            'https://www.superheroapi.com/api.php/1004803797442789/$id/biography');

        if (responseDatos.statusCode == 200) {
          final Map<String, dynamic> datosResponse = responseDatos.data;
          final HeroeDatos datos = HeroeDatos.fromJson(datosResponse);

          setState(() {
            heroeDatos = datos;
          });
        } else {
          print("Error al cargar los datos del héroe.");
        }
      } else {
        setState(() {
          heroeDatos =
              null; // Restablecer los datos del héroe si no se encuentra.
        });
      }
    } else {
      print("Error al buscar el héroe por nombre o ID.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscador de Héroes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Buscar por nombre o ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final searchTerm = searchController.text;
                      if (searchTerm.isNotEmpty) {
                        searchHeroe(searchTerm);
                      }
                    },
                    child: Text('Buscar'),
                  ),
                ],
              ),
            ),
            if (heroeDatos != null)
              Card(
                elevation: 5,
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network(
                      heroeDatos?.imageUrl ?? 'No Data',
                      height: 300,
                      width: 320,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text('Nombre: ${heroeDatos?.fullName ?? "N/A"}',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 10),
                          Text('Alter Egos: ${heroeDatos?.alterEgos ?? "N/A"}',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 10),
                          Text(
                              'Aliases: ${heroeDatos?.aliases.join(", ") ?? "N/A"}',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 10),
                          Text(
                              'Place of Birth: ${heroeDatos?.placeOfBirth ?? "N/A"}',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 10),
                          Text(
                              'First Appearance: ${heroeDatos?.firstAppearance ?? "N/A"}',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 10),
                          Text('Publisher: ${heroeDatos?.publisher ?? "N/A"}',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 10),
                          Text('Alignment: ${heroeDatos?.alignment ?? "N/A"}',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
