import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Models/heroes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Heroe? heroe;
  TextEditingController searchController =
      TextEditingController(); // Controlador para el campo de búsqueda.
  int heroeId = 1;

  @override
  void initState() {
    super.initState();
    getHeroe();
  }

  Future<void> getHeroe() async {
    final response = await Dio()
        .get('https://www.superheroapi.com/api.php/1004803797442789/$heroeId');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;

      final String id = responseData["id"];
      final String name = responseData["name"];
      final String imageUrl = responseData["image"]["url"];

      setState(() {
        heroe = Heroe(id: id, name: name, imageUrl: imageUrl);
      });
    } else {
      print("Error al cargar los datos del héroe.");
    }
  }

  void incrementHeroeId() {
    setState(() {
      heroeId++;
    });
    getHeroe();
  }

  void decrementHeroeId() {
    if (heroeId > 1) {
      setState(() {
        heroeId--;
      });
      getHeroe();
    }
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

        setState(() {
          heroe = Heroe(id: id, name: name, imageUrl: imageUrl);
        });
      } else {
        setState(() {
          heroe = null; // Restablecer el héroe si no se encuentra.
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
            Card(
              elevation: 5,
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network(
                    heroe?.imageUrl ?? 'No Data',
                    height: 300, 
                    width: 320, 
                    fit: BoxFit.cover, 
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('ID: ${heroe?.id ?? "N/A"}',
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        Text('Nombre: ${heroe?.name ?? "N/A"}',
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: incrementHeroeId,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: decrementHeroeId,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
