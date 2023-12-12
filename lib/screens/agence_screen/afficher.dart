import 'package:flutter/material.dart';
import 'agence.dart' as AgenceModel;
import 'modifier.dart';
import 'ajouter.dart'; // Importez la page Ajouter
import 'agence_service.dart' as AgenceService;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agences'),
      ),
      body: FutureBuilder<List<AgenceModel.Agence>>(
        future: agences,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return AgenceGridItem(agence: snapshot.data![index]);
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
    );
  }
}

class AgenceGridItem extends StatelessWidget {
  final AgenceModel.Agence agence;

  AgenceGridItem({required this.agence});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  // Refresh the list of agencies after deletion
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
    );
  }
}
