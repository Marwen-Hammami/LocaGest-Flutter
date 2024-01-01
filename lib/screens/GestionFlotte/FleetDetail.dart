import 'package:flutter/material.dart';
import 'package:locagest/models/car.dart';
import 'package:locagest/services/carService.dart';
import 'package:locagest/widgets/CarCard.dart';
import 'package:locagest/screens/GestionFlotte/AddCar.dart'; // Importez votre écran AddCar

class FleetDetail extends StatefulWidget {
  @override
  _FleetDetailState createState() => _FleetDetailState();
}

class _FleetDetailState extends State<FleetDetail> {
  final CarService carService = CarService();
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    try {
      List<Car> fetchedCars = await carService.getAllCars();
      setState(() {
        cars = fetchedCars;
      });
    } catch (e) {
      print('Erreur de chargement des voitures : $e');
      // Gérer les erreurs de chargement des voitures
    }
  }

  Future<void> _refresh() async {
    // Mettez à jour la liste des voitures
    await fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocaGest'),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Action à effectuer lors de l'appui sur le bouton '+'
              // (peut être la navigation vers une autre page pour ajouter une voiture)
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightGreen[100],
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            return CarCard(
              car: cars[index],
              carService: carService,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'interface AddCar lors de l'appui sur le bouton flottant
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCar()),
          );
        },
        backgroundColor: Colors.green, // Couleur du bouton flottant
        child: Icon(Icons.add), // Icône du bouton flottant
      ),
    );
  }
}
