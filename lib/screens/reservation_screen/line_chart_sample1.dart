import 'package:locagest/ressources/app_ressources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locagest/ressources/app_colors.dart';

class LineChart1 extends StatelessWidget {
  const LineChart1({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: [lineChartBarData1_1],
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: [lineChartBarData2_1],
        minX: 0,
        maxX: 12,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10';
        break;
      case 2:
        text = '20';
        break;
      case 3:
        text = '30';
        break;
      case 4:
        text = '40';
        break;
      case 5:
        text = '50';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta, {double space = 10}) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
        case 2:
        text = const Text('FEV', style: style);
        break;
      case 4:
        text = const Text('MARS', style: style);
        break;
        case 6:
        text = const Text('AVR', style: style);
        break;
      case 8:
        text = const Text('MAI', style: style);
        break;
        case 10:
        text = const Text('JUIN', style: style);
        break;

      case 12:
        text = const Text('JUIL', style: style);
        break;
        case 14:
        text = const Text('AOUT', style: style);
        break;

      case 16:
        text = const Text('SEP', style: style);
        break;
        case 18:
        text = const Text('OCT', style: style);
        break;

      case 20:
        text = const Text('NOV', style: style);
        break;
        case 22:
        text = const Text('DEC', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space:  space,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 2,
        getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, space: 5),
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: Color.fromARGB(255, 182, 121, 196).withOpacity(0.2),
              width: 4),
          left: const BorderSide(color: Color.fromARGB(208, 211, 104, 191)),
          right: const BorderSide(color: Color.fromARGB(208, 211, 104, 191)),
          top: const BorderSide(color: Color.fromARGB(208, 211, 104, 191)),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Color.fromARGB(255, 178, 142, 213),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.contentColorPink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: Color.fromARGB(255, 178, 142, 213),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Color.fromARGB(255, 214, 172, 214).withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: AppColors.contentColorPink.withOpacity(0.2),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Color.fromARGB(255, 178, 142, 213).withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              // const Text(
              //   'Monthly Sales',
              //   style: TextStyle(
              //     color: Color.fromARGB(255, 178, 142, 213),
              //     fontSize: 32,
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 2,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: LineChart1(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: const Color.fromARGB(255, 7, 0, 0)
                  .withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}
