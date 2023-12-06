import 'package:flutter/material.dart';

var s_message = 'ici le message';
var s_image =
    'https://cdn.pixabay.com/photo/2023/11/29/22/56/goldfish-8420416_1280.jpg';
//'';

class TreatmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traiter les Signalements'),
      ),
      body: Padding(
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
            if (s_image.isNotEmpty)
              Image.network(
                s_image,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              )
            else
              Image.asset(
                'assets/images/no_image.jpg',
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
