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
        primarySwatch: Colors.blue,
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
        title: const Text('Agences'),
      ),
      body: Center(
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
                          launchMapURL:
                              launchMapURL, // Passer la référence de la méthode
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
                          agences = AgenceService.AgenceService.fetchAgences();
                        });
                      });
                    },
                    child: Text('Ajouter'),
                  ),
                  SizedBox(height: 16),
                ],
              );
            }
          },
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
                      // Appeler la méthode launchMapURL de Afficher directement
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
      child: Card(
        child: ListTile(
          title: Text(agence.agenceName),
          subtitle: Text(agence.adresse),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Modifier(agence: agence),
                    ),
                  ).then((value) {
                    AgenceService.AgenceService.fetchAgences();
                  });
                },
                child: const Text('Modifier'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await AgenceService.AgenceService.supprimer(agence.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Agence supprimée avec succès'),
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  } catch (e) {
                    print('Error deleting agence: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Erreur lors de la suppression de l\'agence'),
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                },
                child: const Text('Supprimer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
