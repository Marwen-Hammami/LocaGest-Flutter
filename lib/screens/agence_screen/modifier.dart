import 'package:flutter/material.dart';
import 'agence.dart';
import 'agence_service.dart';

class Modifier extends StatefulWidget {
  final Agence agence;

  Modifier({required this.agence});

  @override
  _ModifierState createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {
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

    // Convertir les valeurs double en chaînes de caractères pour les contrôleurs de texte
    longitudeController.text = widget.agence.longitude.toString();
    latitudeController.text = widget.agence.latitude.toString();
  }

  @override
  void dispose() {
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
        title: Text('Modifier Agence'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom Agence'),
              // Assigner la valeur existante
              // dans le TextField pour l'agenceName
              // avant la modification
              onChanged: (value) {
                widget.agence.agenceName = value;
              },
            ),
            TextField(
              controller: adresseController,
              decoration: InputDecoration(labelText: 'Adresse'),
              // Assigner la valeur existante
              // dans le TextField pour l'adresse
              // avant la modification
              onChanged: (value) {
                widget.agence.adresse = value;
              },
            ),
            TextField(
              controller: longitudeController,
              decoration: InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Convertir la chaîne de caractères en double
                widget.agence.longitude = double.tryParse(value) ?? 0.0;
              },
            ),
            TextField(
              controller: latitudeController,
              decoration: InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Convertir la chaîne de caractères en double
                widget.agence.latitude = double.tryParse(value) ?? 0.0;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AgenceService.modifier(widget.agence.id, widget.agence);
                Navigator.pop(context);
              },
              child: Text('Modifier'),
            ),
          ],
        ),
      ),
    );
  }
}
