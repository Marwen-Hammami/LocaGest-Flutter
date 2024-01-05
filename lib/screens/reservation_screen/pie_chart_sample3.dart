import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:locagest/models/reservation.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State<PieChartSample3> {
  Map<String, int> statutStatistics = {};
  int touchedIndex = 0;

  late List<Reservation> fetchstatut = [];

  @override
  void initState() {
    super.initState();
    // Chargez les données depuis le backend lors de l'initialisation
    fetchDataFromBackend();
  }

  Map<String, int> calculateStatutStatistics() {
    Map<String, int> statutStatistics = {
      'Réservée': 0,
      'Payée': 0,
      'Achevée': 0,
    };

    for (var reservation in fetchstatut) {
      switch (reservation.Statut) {
        case 'Réservée':
          statutStatistics['Réservée'] =
              (statutStatistics['Réservée'] ?? 0) + 1;
          break;
        case 'Payée':
          statutStatistics['Payée'] = (statutStatistics['Payée'] ?? 0) + 1;
          break;
        case 'Achevée':
          statutStatistics['Achevée'] = (statutStatistics['Achevée'] ?? 0) + 1;
          break;
      }
    }

    return statutStatistics;
  }

  Future<void> fetchDataFromBackend() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:9090/res'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("-----------------" + response.body);

        setState(() {
          // Convertissez
          fetchstatut = data.map((json) => Reservation.fromJson(json)).toList();
        });
      } else {
        throw Exception('Erreur de chargement des données depuis le backend');
      }
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> statutMap = calculateStatutStatistics();
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(statutMap),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(Map<String, int> statutStatistics) {
    return List.generate(statutStatistics.length, (i) {
      final statut = statutStatistics.keys.elementAt(i);
      final value = statutStatistics[statut] ?? 0;
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: getColorForStatut(statut),
        value: value.toDouble(),
        title: '${value.toString()}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          getBadgeAssetForStatut(statut),
          size: widgetSize,
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }

  Color getColorForStatut(String statut) {
    switch (statut) {
      case 'Réservée':
        return const Color.fromARGB(255, 59, 158, 161);
      case 'Payée':
        return const Color.fromARGB(255, 225, 139, 211);
      case 'Achevée':
        return const Color.fromARGB(255, 145, 113, 201);
      default:
        throw Exception('Oh no');
    }
  }

  String getBadgeAssetForStatut(String statut) {
    switch (statut) {
      case 'Réservée':
        return 'assets/fonts/verified.png';
      case 'Payée':
        return 'assets/fonts/bell.png';
      case 'Achevée':
        return 'assets/fonts/pay-per-click.png';
      default:
        throw Exception('Oh no');
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.pngAsset, {
    required this.size,
    required this.borderColor,
  });

  final String pngAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          pngAsset,
        ),
      ),
    );
  }
}
