import 'package:flutter/material.dart';
import 'package:locagest/screens/chat_screen/signalement_traitement.dart';
import 'package:locagest/screens/chat_screen/banned_words_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utilities/colors.dart';

class OrdinalBar {
  final String x;
  final int y;

  OrdinalBar(this.x, this.y);
}

class ChatResponsiveDashboard extends StatefulWidget {
  @override
  _ChatResponsiveDashboardState createState() =>
      _ChatResponsiveDashboardState();
}

class _ChatResponsiveDashboardState extends State<ChatResponsiveDashboard> {
  String selectedTimeFilter = 'Aujourd\'hui'; // Initial value for the dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signalements'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TreatmentScreen(),
                      ),
                    );
                  },
                  child: const Text("Traiter les signalements"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BannedWordsScreen(),
                      ),
                    );
                  },
                  child: const Text("Gérer les mots à bannir"),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Pie Chart Section
            const Text(
              'Nombre des Signalements',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            _buildPieChartSection(),
            SizedBox(height: 20.0),
            // Bar Chart Section
            const Text(
              'Utilisation des mots bannis',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // You can customize the color if needed
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  BarChartSection(
                    chartTitle: 'Mots les plus utilisées',
                    chartData: [
                      OrdinalBar('5ayb', 16),
                      OrdinalBar('####', 14),
                      OrdinalBar('???', 12),
                      OrdinalBar('bad', 9),
                      OrdinalBar('mauvais', 7),
                      OrdinalBar('zero', 7),
                      OrdinalBar('mort', 6),
                    ],
                  ),
                  BarChartSection(
                    chartTitle: 'Mots les moins utilisées',
                    chartData: [
                      OrdinalBar('insert', 0),
                      OrdinalBar('null', 1),
                      OrdinalBar('%%%', 1),
                      OrdinalBar('tuer', 1),
                      OrdinalBar('!?#', 2),
                      OrdinalBar('!!!!', 3),
                      OrdinalBar('@@@', 3),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartSection() {
    return Column(
      children: [
        // Dropdown Section
        DropdownButton<String>(
          value: selectedTimeFilter,
          items: ['Aujourd\'hui', 'Semaine', 'Mois', 'Total']
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedTimeFilter = newValue;
              });
            }
          },
        ),
        // Pie Chart Section
        Container(
          height: 300.0,
          child: SfCircularChart(
            series: <CircularSeries>[
              PieSeries<PieData, String>(
                dataSource: _getPieChartData(),
                xValueMapper: (PieData data, _) => data.label,
                yValueMapper: (PieData data, _) => data.value,
                dataLabelMapper: (PieData data, _) =>
                    '${data.label}: ${data.value}',
                dataLabelSettings: DataLabelSettings(isVisible: true),
                pointColorMapper: (PieData data, _) {
                  return data.label == 'Traité'
                      ? AppColors.mainColor
                      : AppColors.accentColor;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieData> _getPieChartData() {
    // Replace this with your actual data
    switch (selectedTimeFilter) {
      case 'Aujourd\'hui':
        return [
          PieData('Traité', 12),
          PieData('Non traité', 4),
        ];
        break;
      case 'Semaine':
        return [
          PieData('Traité', 33),
          PieData('Non traité', 9),
        ];
        break;
      case 'Mois':
        return [
          PieData('Traité', 70),
          PieData('Non traité', 30),
        ];
        break;
      case 'Total':
        return [
          PieData('Traité', 170),
          PieData('Non traité', 37),
        ];
        break;
      default:
        return [
          PieData('Traité', 1),
          PieData('Non traité', 1),
        ];
    }
  }
}

class BarChartSection extends StatelessWidget {
  final String chartTitle;
  final List<OrdinalBar> chartData;

  BarChartSection({required this.chartTitle, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chartTitle,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 200.0,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<OrdinalBar, String>(
                  dataSource: chartData,
                  xValueMapper: (OrdinalBar sales, _) => sales.x,
                  yValueMapper: (OrdinalBar sales, _) => sales.y,
                  color: AppColors.mainColor, // Use the mainColor here
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PieData {
  final String label;
  final double value;

  PieData(this.label, this.value);
}
