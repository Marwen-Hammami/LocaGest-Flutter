import 'package:flutter/material.dart';
import 'agence.dart' as AgenceModel;
import 'modifier.dart';
import 'ajouter.dart'; // Importez la page Ajouter
import 'agence_service.dart' as AgenceService;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agences',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Afficher(),
    );
  }
}

class Afficher extends StatefulWidget {
  @override
  _AfficherState createState() => _AfficherState();
}

class _AfficherState extends State<Afficher> {
  late Future<List<AgenceModel.Agence>> agences;

  @override
  void initState() {
    super.initState();
    agences = AgenceService.AgenceService.fetchAgences();
  }

  Future<void> launchMapURL(double latitude, double longitude) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agences',
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
        child: Center(
          child: FutureBuilder<List<AgenceModel.Agence>>(
            future: agences,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No data available');
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AgenceGridItem(
                            agence: snapshot.data![index],
                            launchMapURL: launchMapURL,
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ajouter(),
                          ),
                        ).then((value) {
                          setState(() {
                            agences =
                                AgenceService.AgenceService.fetchAgences();
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            255, 3, 141, 8), // Set background color to green
                      ),
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Set text to bold
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AgenceGridItem extends StatelessWidget {
  final AgenceModel.Agence agence;
  final Function(double, double) launchMapURL;

  AgenceGridItem({required this.agence, required this.launchMapURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('${agence.agenceName} Détails'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Address: ${agence.adresse}\nLatitude: ${agence.latitude}\nLongitude: ${agence.longitude}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      launchMapURL(agence.latitude, agence.longitude);
                    },
                    child: const Text('Voir sur la carte'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fermer'),
                ),
              ],
            );
          },
        );
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.7, // 90% de la largeur de l'écran
          child: Card(
            color: Color.fromARGB(255, 177, 158, 228),
            child: ListTile(
              title: Text(
                agence.agenceName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                agence.adresse,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Modifier(agence: agence),
                        ),
                      ).then((value) {
                        if (value != null && value) {
                          AgenceService.AgenceService.fetchAgences();
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () async {
                      try {
                        await AgenceService.AgenceService.supprimer(agence.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Agence supprimée avec succès'),
                          ),
                        );
                      } catch (e) {
                        print('Error deleting agence: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Erreur lors de la suppression de l\'agence'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
