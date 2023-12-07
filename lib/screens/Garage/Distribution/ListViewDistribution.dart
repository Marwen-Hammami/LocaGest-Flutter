import 'package:flutter/material.dart';
import 'package:locagest/screens/Garage/Distribution/ModifyDistribution.dart';

void main() => runApp(const ListViewDistribution());

class ListViewDistribution extends StatelessWidget {
  const ListViewDistribution({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Liste des distributions')),
        body: const DataTableExample(),
      ),
    );
  }
}

class DataTableExample extends StatelessWidget {
  const DataTableExample({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              const Color.fromARGB(255, 223, 223, 227),
            ],
          ),
        ),
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Cars',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Start Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'End Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),

          DataColumn(
            label: Expanded(
              child: Text(
                'Status',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Actions',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Peugeot')),
              DataCell(Text('30-09-2023')),
              DataCell(Text('15-10-2023')),
              DataCell(Text('Delivred')),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyDistributionScreen()),
                    );
                  },
                  child: Text('Update'),
                ),
              ),

            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Mercedes')),
              DataCell(Text('15-09-2024')),
              DataCell(Text('15-10-2024')),
              DataCell(Text('In progress')),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyDistributionScreen()),
                    );
                  },
                  child: Text('Update'),
                ),
              ),

            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Kia')),
              DataCell(Text('12-07-2022')),
              DataCell(Text('15-08-2022')),
              DataCell(Text('Delivred')),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyDistributionScreen()),
                    );
                  },
                  child: Text('Update'),
                ),
              ),

            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('BMW')),
              DataCell(Text('12-07-2022')),
              DataCell(Text('15-08-2022')),
              DataCell(Text('In progress')),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyDistributionScreen()),
                    );
                  },
                  child: Text('Update'),
                ),
              ),

            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Mazda')),
              DataCell(Text('12-07-2022')),
              DataCell(Text('15-08-2022')),
              DataCell(Text('Delivred')),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyDistributionScreen()),
                    );
                  },
                  child: Text('Update'),
                ),
              ),


            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Hyundai')),
              DataCell(Text('12-07-2022')),
              DataCell(Text('15-08-2022')),
              DataCell(Text('Delivred')),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyDistributionScreen()),
                    );
                  },
                  child: Text('Update'),
                ),
              ),






            ],
          ),
        ],
      ),
    );
  }
}
