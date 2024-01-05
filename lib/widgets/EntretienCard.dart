import 'package:flutter/material.dart';
import 'package:locagest/models/historiqueentretien.dart';
import 'package:locagest/services/entretienService.dart';

class EntretienCard extends StatelessWidget {
  final HistoriqueEntretien entretien;
  final EntretienService entretienService;

  EntretienCard({required this.entretien, required this.entretienService});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Naviguer vers l'interface de détail de l'entretien lors de l'appui sur la carte
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => EntretienDetail(entretien: entretien, entretienService: entretienService),
        //   ),
        // );
      },
      child: Container(
        width: 2000, // Ajustez la largeur selon vos besoins
        child: Card(
          margin: EdgeInsets.all(8.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/images/your_background_image.jpg'), // Utilisez entretien.image comme URL de l'image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Titre: ${entretien.titre}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Immatriculation: ${entretien.immatriculation}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cartype: ${entretien.cartype}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
