import 'package:locagest/screens/agence_screen/Resources/agenceRequest.dart';
import 'package:flutter/material.dart';
import 'agence_service.dart';

class Ajouter extends StatefulWidget {
  @override
  _AjouterState createState() => _AjouterState();
}

class _AjouterState extends State<Ajouter> {
  late TextEditingController nomController;
  late TextEditingController adresseController;
  late TextEditingController longitudeController;
  late TextEditingController latitudeController;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController();
    adresseController = TextEditingController();
    longitudeController = TextEditingController();
    latitudeController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose des contrôleurs de texte pour libérer les ressources lorsqu'ils ne sont plus utilisés
    nomController.dispose();
    adresseController.dispose();
    longitudeController.dispose();
    latitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter Agence',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 114, 157, 243),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom Agence'),
            ),
            TextField(
              controller: adresseController,
              decoration: InputDecoration(labelText: 'Adresse'),
            ),
            TextField(
              controller: longitudeController,
              decoration: InputDecoration(labelText: 'Longitude'),
              keyboardType:
                  TextInputType.number, // Définir le clavier pour les nombres
            ),
            TextField(
              controller: latitudeController,
              decoration: InputDecoration(labelText: 'Latitude'),
              keyboardType:
                  TextInputType.number, // Définir le clavier pour les nombres
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Convertir les valeurs de String à double
                double longitude =
                    double.tryParse(longitudeController.text) ?? 0.0;
                double latitude =
                    double.tryParse(latitudeController.text) ?? 0.0;

                AgenceService.ajouter(
                  AgenceRequest(
                    agenceName: nomController.text,
                    adresse: adresseController.text,
                    longitude: longitude,
                    latitude: latitude,
                  ),
                );
                Navigator.pop(context); // Revenir à l'écran précédent
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
