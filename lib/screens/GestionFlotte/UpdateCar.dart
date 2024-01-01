import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locagest/models/car.dart';
import 'package:locagest/services/carService.dart';

class UpdateCar extends StatefulWidget {
  @override
  _UpdateCarState createState() => _UpdateCarState();
}

class _UpdateCarState extends State<UpdateCar> {
  CarService _carService = CarService();
  List<String> carburantOptions = ['Essence', 'Diesel'];
  List<String> boiteOptions = ['Manuelle', 'Automatique'];
  XFile? _selectedImage;
  late Car _newCar;

  @override
  void initState() {
    super.initState();
    _newCar = Car(
      immatriculation: '', // Set the matricule directly
      marque: '',
      modele: '',
      carburant: carburantOptions[0],
      boite: boiteOptions[0],
      image: '',
    );
  }

  Future<void> _pickImage() async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
        _newCar.image = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Voiture'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightGreen, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: _selectedImage == null
                      ? Image.asset(
                          'assets/your_logo.png',
                          height: 100,
                        )
                      : Image.file(
                          File(_selectedImage!.path),
                          height: 100,
                        ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Immatriculation'),
                onChanged: (value) {
                  setState(() {
                    _newCar.immatriculation = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Marque'),
                onChanged: (value) {
                  setState(() {
                    _newCar.marque = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Modèle'),
                onChanged: (value) {
                  setState(() {
                    _newCar.modele = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _newCar.carburant,
                onChanged: (value) {
                  setState(() {
                    _newCar.carburant = value;
                  });
                },
                items: carburantOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Carburant'),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _newCar.boite,
                onChanged: (value) {
                  setState(() {
                    _newCar.boite = value;
                  });
                },
                items: boiteOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Boîte de Vitesse'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _carService.updateCar(_newCar.immatriculation, _newCar);
                    Navigator.pop(context);
                  } catch (e) {
                    print('Failed to update car: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('Modifier la voiture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
