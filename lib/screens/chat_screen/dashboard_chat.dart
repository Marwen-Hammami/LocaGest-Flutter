import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrdinalBar {
  final String x;
  final int y;

  OrdinalBar(this.x, this.y);
}

class ChatResponsiveDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signalements'),
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
                    // Handle "Traiter les signalements" button click
                    // Add the logic for what should happen when this button is clicked
                  },
                  child: const Text("Traiter les signalements"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle "Gérer les mots à bannir" button click
                    // Add the logic for what should happen when this button is clicked
                  },
                  child: const Text("Gérer les mots à bannir"),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            BarChartSection(
              chartTitle: 'Chart 1',
              chartData: [
                OrdinalBar('Jan', 5),
                OrdinalBar('Feb', 25),
                OrdinalBar('Mar', 160),
                OrdinalBar('Apr', 75),
              ],
            ),
            const Text(
              'Utilisation des mots bannis',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // You can customize the color if needed
              ),
            ),
            BarChartSection(
              chartTitle: 'Mots les plus utilisées',
              chartData: [
                OrdinalBar('5ayb', 12),
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
                OrdinalBar('!!!!', 3),
              ],
            ),
          ],
        ),
      ),
    );
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
