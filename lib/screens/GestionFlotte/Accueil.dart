import 'package:flutter/material.dart';
import 'package:locagest/screens/GestionFlotte/FleetDetail.dart';
import 'package:locagest/screens/GestionFlotte/EntretienHome.dart';




class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocaGest'),
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Colors.lightGreen[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card 1
             GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FleetDetail()),
                );
              },
            child:MyCard(
              title: 'Consulter les voitures',
              color: Colors.yellow,
              imageAsset: 'assets/images/voiture_image.png',
            ),
            ),
            SizedBox(height: 20),
            // Card 2
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntretienHome()),
                );
                },
            child:MyCard(
              title: 'Voir les Entretiens',
              color: Colors.red,
              imageAsset: 'assets/images/kolleb.png',
            ),
            ),
            SizedBox(height: 20),
            // Card 3
            MyCard(
              title: 'Geolocalisation',
              color: Colors.green,
              imageAsset: 'assets/images/localisation.png',
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String title;
  final Color color;
  final String imageAsset;

  MyCard({required this.title, required this.color, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 200,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: 80,
              height: 80,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
