import 'package:flutter/material.dart';
import 'package:locagest/models/historiqueentrentien.dart';
import 'package:locagest/services/entretienService.dart';
import 'package:locagest/widgets/EntretienCard.dart';

class EntretienHome extends StatefulWidget {
  @override
  _EntretienHomeState createState() => _EntretienHomeState();
}

class _EntretienHomeState extends State<EntretienHome> {
  final EntretienService entretienService = EntretienService();
  List<HistoriqueEntretien> entretiens = [];

  @override
  void initState() {
    super.initState();
    fetchEntretiens();
  }

  Future<void> fetchEntretiens() async {
    try {
      List<HistoriqueEntretien> fetchedEntretiens = await entretienService.getAllEntretiens();
      setState(() {
        entretiens = fetchedEntretiens;
      });
    } catch (e) {
      print('Erreur de chargement des voitures : $e');
      // Gérer les erreurs de chargement des voitures
    }
  }


  Future<void> _refresh() async {
    // Mettez à jour la liste des entretiens
    await fetchEntretiens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocaGest'),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Action à effectuer lors de l'appui sur le bouton '+'
              // (peut être la navigation vers une autre page pour ajouter un entretien)
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightGreen[100],
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: entretiens.length,
          itemBuilder: (context, index) {
            return EntretienCard(
              entretien: entretiens[index],
              entretienService: entretienService,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'interface AddEntretien lors de l'appui sur le bouton flottant
          //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => AddEntretien()),
          //);
        },
        backgroundColor: Colors.green, // Couleur du bouton flottant
        child: Icon(Icons.add), // Icône du bouton flottant
      ),
    );
  }
}
