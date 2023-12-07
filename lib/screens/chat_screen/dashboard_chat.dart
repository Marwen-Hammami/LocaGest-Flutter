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

class ChatResponsiveDashboard extends StatelessWidget {
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
                          builder: (context) => TreatmentScreen()),
                    );
                  },
                  child: const Text("Traiter les signalements"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BannedWordsScreen()),
                    );
                    //ici appeler la nouvelle interface BannedWordsScreen()
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
