// CarDetail.dart
import 'package:flutter/material.dart';
import 'package:locagest/models/car.dart';

class CarDetail extends StatelessWidget {
  final Car car;

  CarDetail({required this.car});

  Future<void> deleteCar(BuildContext context) async {
    try {
      // Action à effectuer lors de la suppression
      // Vous pouvez appeler une fonction de service ou effectuer d'autres actions ici
      // await carService.deleteCar(car.immatriculation);
      
      // Après la suppression réussie, vous pouvez naviguer vers une autre page ou effectuer d'autres actions.
      Navigator.pop(context); // Revenir à l'écran précédent après la suppression
    } catch (e) {
      // Gérer les erreurs liées à la suppression
      print('Erreur lors de la suppression du véhicule : $e');
      // Affichez un message d'erreur à l'utilisateur si nécessaire
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la suppression du véhicule'),
        backgroundColor: Colors.red,
      ));
    }
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
            height: 200,
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
                Text('Marque: ${car.marque}'),
                Text('Modèle: ${car.modele}'),
                Text('Carburant: ${car.carburant}'),
                Text('Boite: ${car.boite}'),
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
                // Action à effectuer lors de l'appui sur le bouton "Modifier"
              },
              child: Text(
                'Modifier',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () => deleteCar(context), // Appeler la fonction _deleteCar
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
