import 'package:flutter/material.dart';

class BannedWordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer les mots Bannis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                _showBanWordDialog(context); // Show the ban word dialog
              },
              child: const Text('Bannir un mot'),
            ),
            SizedBox(height: 10.0),
            _buildBannedWordsTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildBannedWordsTable() {
    List<Map<String, dynamic>> bannedWordsData = [
      {'word': 'Mot1', 'usageCount': 10},
      {'word': 'Mot2', 'usageCount': 5},
      {'word': 'Mot3', 'usageCount': 8},
    ];

    return DataTable(
      columns: const [
        DataColumn(label: Text('Mot')),
        DataColumn(label: Text('Nombre utilisations')),
        DataColumn(label: Text('Actions')),
      ],
      rows: bannedWordsData
          .map(
            (data) => DataRow(cells: [
              DataCell(Text(data['word'].toString())),
              DataCell(Text(data['usageCount'].toString())),
              DataCell(
                ElevatedButton.icon(
                  onPressed: () {
                    //on click
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
  }

  void _showBanWordDialog(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Saisir le mot à bannir'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textFieldController,
                decoration: InputDecoration(labelText: 'Mot'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String wordToBan = textFieldController.text;
                  // Add logic to handle the ban word action
                  print('Banning word: $wordToBan');
                  Navigator.pop(context); // Close the dialog
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
      },
    );
  }
}
