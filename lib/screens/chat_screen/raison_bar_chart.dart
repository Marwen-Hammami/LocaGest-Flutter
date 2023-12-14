import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:locagest/models/Signalement.dart';

import '../../utilities/colors.dart';

class _BarChartRaisons extends StatelessWidget {
  final List<Signalement> signalements;

  const _BarChartRaisons({required this.signalements});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.mainColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = signalements[value.toInt()]
        .raison; // Assuming `raison` is a property in Signalement
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.mainColor,
          AppColors.accentColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> groups = [];

    for (int i = 0; i < signalements.length; i++) {
      groups.add(BarChartGroupData(
        x: i.toInt(),
        barRods: [
          BarChartRodData(
            toY: 10,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ));
    }

    return groups;
  }
}

class BarCharRaisonDeSignalement extends StatefulWidget {
  final List<Signalement> signalements; // Add this line

  const BarCharRaisonDeSignalement({
    required this.signalements,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartRaison();
}

class BarChartRaison extends State<BarCharRaisonDeSignalement> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChartRaisons(signalements: widget.signalements),
    );
  }
}
