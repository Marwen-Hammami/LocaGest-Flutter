import 'package:flutter/material.dart';
import 'package:locagest/models/BannedWord.dart';
import 'package:locagest/services/BannedWordService.dart';

class BannedWordsScreen extends StatefulWidget {
  @override
  _BannedWordsScreenState createState() => _BannedWordsScreenState();
}

class _BannedWordsScreenState extends State<BannedWordsScreen> {
  final BannedWordService bannedWordService = BannedWordService();
  List<BannedWord> bannedWords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer les mots Bannis'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showBanWordDialog(context);
                },
                child: const Text('Bannir un mot'),
              ),
              SizedBox(height: 10.0),
              FutureBuilder<List<BannedWord>>(
                future: bannedWordService.getBannedWords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No banned words available.');
                  } else {
                    bannedWords = snapshot.data!;
                    return _buildBannedWordsTable(bannedWords);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannedWordsTable(List<BannedWord> bannedWords) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Mot')),
        DataColumn(label: Text('Nombre utilisations')),
        DataColumn(label: Text('Actions')),
      ],
      rows: bannedWords
          .map(
            (data) => DataRow(cells: [
              DataCell(Text(data.word)),
              DataCell(Text(data.usedCount.toString())),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    bool confirmed =
                        await _showDeleteConfirmationDialog(context);

                    if (confirmed) {
                      // Handle delete action
                      String? wordId = data.id;

                      if (wordId != null) {
                        await bannedWordService.deleteBannedWord(wordId);

                        // Fetch the updated list of banned words
                        List<BannedWord> updatedBannedWords =
                            await bannedWordService.getBannedWords();

                        // Set state to rebuild the UI with the updated list of banned words
                        setState(() {
                          bannedWords = updatedBannedWords;
                        });
                      } else {
                        print('Error: Cannot delete a word with null ID.');
                      }
                    }
                  },
                ),
              ),
            ]),
          )
          .toList(),
    );
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Êtes-vous sûre de vouloir supprimer ce mot banni ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User chose to cancel
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User chose to confirm
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  void _showBanWordDialog(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildBanWordDialog(context, textFieldController);
      },
    );
  }

  Widget _buildBanWordDialog(
      BuildContext context, TextEditingController controller) {
    return AlertDialog(
      title: Text('Saisir le mot à bannir'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Mot'),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              String wordToBan = controller.text;

              // Call the service to create the banned word
              await bannedWordService.createBannedWord(wordToBan);

              // Fetch the updated list of banned words
              List<BannedWord> updatedBannedWords =
                  await bannedWordService.getBannedWords();

              // Close the dialog
              Navigator.pop(context);

              // Set state to rebuild the UI with the updated list of banned words
              setState(() {
                bannedWords = updatedBannedWords;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: const Text(
              'Bannir',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
