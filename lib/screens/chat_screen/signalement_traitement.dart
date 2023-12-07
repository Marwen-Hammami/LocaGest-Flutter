import 'package:flutter/material.dart';

var s_message = 'ici le message';
var s_image =
    'https://cdn.pixabay.com/photo/2023/11/29/22/56/goldfish-8420416_1280.jpg';
// '';

class TreatmentScreen extends StatefulWidget {
  @override
  _TreatmentScreenState createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  String _selectedDeleteOption = 'Non';
  String _selectedBanOption = 'Non';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traiter les Signalements'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Message:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                s_message,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              const Text(
                'Image:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  // Show the image in full screen here
                  _showFullScreenImage();
                },
                child: s_image.isNotEmpty
                    ? Image.network(
                        s_image,
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/no_image.jpg',
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(height: 20.0),
              const Text(
                'Supprimer le message:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioListTile<String>(
                title: const Text('Non'),
                value: 'Non',
                groupValue: _selectedDeleteOption,
                onChanged: (value) {
                  setState(() {
                    _selectedDeleteOption = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Oui'),
                value: 'Oui',
                groupValue: _selectedDeleteOption,
                onChanged: (value) {
                  setState(() {
                    _selectedDeleteOption = value!;
                  });
                },
              ),
              SizedBox(height: 20.0),
              const Text(
                'Bannir:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioListTile<String>(
                title: const Text('Non'),
                value: 'Non',
                groupValue: _selectedBanOption,
                onChanged: (value) {
                  setState(() {
                    _selectedBanOption = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Sender'),
                value: 'Sender',
                groupValue: _selectedBanOption,
                onChanged: (value) {
                  setState(() {
                    _selectedBanOption = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Reporter'),
                value: 'Reporter',
                groupValue: _selectedBanOption,
                onChanged: (value) {
                  setState(() {
                    _selectedBanOption = value!;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Handle the action when the "Effectué" button is pressed
                  // Add the logic for what should happen when this button is clicked
                },
                child: const Text("Effectué"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: s_image.isNotEmpty
                ? Image.network(
                    s_image,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    'assets/images/no_image.jpg',
                    fit: BoxFit.contain,
                  ),
          ),
        );
      },
    );
  }
}
