import 'package:flutter/material.dart';
import 'package:locagest/models/car.dart';
import 'package:locagest/services/carService.dart'; // Assurez-vous d'importer votre service
import 'package:locagest/screens/GestionFlotte/UpdateCar.dart';

class CarDetail extends StatelessWidget {
  final Car car;
  final CarService carService; // Ajoutez l'instance du service

  CarDetail({required this.car, required this.carService});

  Future<void> deleteCar(BuildContext context) async {
    // Affichez une boîte de dialogue de confirmation avant la suppression
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attention !"),
          content: Text(
              "Cette opération est définitive ! Êtes-vous sûr de vouloir supprimer cette voiture ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Annuler la suppression
              },
              child: Text(
                'Annuler',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmer la suppression
              },
              child: Text(
                'Supprimer',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    // Supprimez la condition confirmDelete et procédez à la suppression directement
    try {
      await carService.deleteCar(car.immatriculation);
    } catch (e) {
      // Ignorer les erreurs de suppression
    }

    // Après la suppression réussie ou échouée, vous pouvez naviguer vers une autre page ou effectuer d'autres actions.
    Navigator.pop(context); // Revenir à l'écran précédent après la suppression
  }

  Widget buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.greenAccent),
        SizedBox(width: 8),
        Text('$label: $value', style: TextStyle(fontSize: 18)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${car.marque} ${car.modele}'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage('assets/images/Dacia_Logan.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                buildInfoRow(
                    'Immatriculation', car.immatriculation, Icons.date_range),
                buildInfoRow('Marque', car.marque, Icons.directions_car),
                buildInfoRow('Modèle', car.modele, Icons.directions_car),
                buildInfoRow('Carburant', car.carburant.toString(),
                    Icons.local_gas_station),
                buildInfoRow('Boite', car.boite.toString(),
                    Icons.settings), // Convertissez en String si nécessaire

                // Ajoutez d'autres champs selon vos besoins
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateCar()),
                );
              },
              child: Text(
                'Modifier',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () => deleteCar(context),
              child: Text(
                'Supprimer',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
