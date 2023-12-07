

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class ReservationStatisticsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Statistiques Générales:'),
        SizedBox(height: 16),
        Container(
          height: 300,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: [
                PieChartSectionData(
                  value: 30, // Remplacez cette valeur par vos statistiques
                  color: Colors.blue,
                  title: 'Complétées',
                  radius: 50,
                ),
                PieChartSectionData(
                  value: 40, // Remplacez cette valeur par vos statistiques
                  color: Colors.green,
                  title: 'En cours',
                  radius: 50,
                ),
                // Ajoutez autant de PieChartSectionData que nécessaire pour vos statistiques
              ],
            ),
          ),
        ),
      ],
    );
  }
}
