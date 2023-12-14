import 'package:flutter/material.dart';
import 'package:locagest/models/BannedWord.dart';
import 'package:locagest/models/Signalement.dart';
import 'package:locagest/screens/chat_screen/banned_words_bar_chart.dart';
import 'package:locagest/screens/chat_screen/signalement_traitement.dart';
import 'package:locagest/screens/chat_screen/banned_words_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../services/BannedWordService.dart';
import '../../services/SignalementService.dart';
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
  final BannedWordService bannedWordService = BannedWordService();
  List<BannedWord> bannedWords = [];

  final SignalementsService signalementsService = SignalementsService();
  List<Signalement> signalements = [];

  String selectedTimeFilter = 'Aujourd\'hui';

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
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 20.0),
            // Pie Chart Section
            const Text(
              'Signalements',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
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

            FutureBuilder<List<Signalement>>(
              future: signalementsService.getSignalements(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No signalements available.');
                } else {
                  // Data is ready, update the list
                  signalements = snapshot.data!;
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildPieChartSection(signalements, "Traité"),
                        _buildPieChartSection(
                            signalements, "Traité Automatiquement"),
                        _buildPieChartSection(
                            signalements, "Signalement Pertinant"),
                      ]);
                }
              },
            ),
            const SizedBox(height: 20.0),
            // Bar Chart Section
            const Text(
              'Utilisation des mots bannis',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureBuilder<List<BannedWord>>(
                    future: bannedWordService.getBannedWords(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No banned words available.');
                      } else {
                        bannedWords = snapshot.data!;
                        return _buildMostBannedWordsBarChart(bannedWords);
                      }
                    },
                  ),
                  FutureBuilder<List<BannedWord>>(
                    future: bannedWordService.getBannedWords(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No banned words available.');
                      } else {
                        bannedWords = snapshot.data!;
                        return _buildLeastBannedWordsBarChart(bannedWords);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartSection(List<Signalement> signalements, String titre) {
    // Pie Chart Section
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titre ?? 'Default Title',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 300.0,
          child: SfCircularChart(
            series: <CircularSeries>[
              PieSeries<PieData, String>(
                dataSource: _getPieChartData(signalements, titre),
                xValueMapper: (PieData data, _) => data.label,
                yValueMapper: (PieData data, _) => data.value,
                dataLabelMapper: (PieData data, _) =>
                    '${data.label}: ${data.value}',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
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

  List<PieData> _getPieChartData(List<Signalement> signalements, String titre) {
    // Replace this with your actual data
    switch (selectedTimeFilter) {
      case 'Aujourd\'hui':
        // Filter signalements for today
        DateTime today = DateTime.now();
        List<Signalement> todaySignalements = signalements
            .where((signalement) => isToday(signalement.createdAt, today))
            .toList();
        if (titre == "Traité") {
          int countT = 0;
          int countNonT = 0;
          todaySignalements.forEach((Signalement signalement) {
            if (signalement.traite) {
              countT += 1;
            } else {
              countNonT += 1;
            }
          });
          return [
            PieData('Traité', countT as double),
            PieData('Non traité', countNonT as double),
          ];
        } else if (titre == "Traité Automatiquement") {
          int countTA = 0;
          int countNonTA = 0;
          todaySignalements.forEach((Signalement signalement) {
            if (signalement.traiteAutomatiquement) {
              countTA += 1;
            } else {
              countNonTA += 1;
            }
          });
          return [
            PieData('Automatiquement', countTA as double),
            PieData('Non Automatiquement', countNonTA as double),
          ];
        } else {
          int countSP = 0;
          int countNonSP = 0;
          todaySignalements.forEach((Signalement signalement) {
            if (signalement.signalementPertinant) {
              countSP += 1;
            } else {
              countNonSP += 1;
            }
          });
          return [
            PieData('Pertinent', countSP as double),
            PieData('Non Pertinent', countNonSP as double),
          ];
        }

      case 'Semaine':
        // Filter signalements for this week
        DateTime now = DateTime.now();
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        DateTime endOfWeek =
            now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

        List<Signalement> weekSignalements = signalements
            .where((signalement) =>
                isWithinWeek(signalement.createdAt, startOfWeek, endOfWeek))
            .toList();
        if (titre == "Traité") {
          int countT = 0;
          int countNonT = 0;
          weekSignalements.forEach((Signalement signalement) {
            if (signalement.traite) {
              countT += 1;
            } else {
              countNonT += 1;
            }
          });
          return [
            PieData('Traité', countT as double),
            PieData('Non traité', countNonT as double),
          ];
        } else if (titre == "Traité Automatiquement") {
          int countTA = 0;
          int countNonTA = 0;
          weekSignalements.forEach((Signalement signalement) {
            if (signalement.traiteAutomatiquement) {
              countTA += 1;
            } else {
              countNonTA += 1;
            }
          });
          return [
            PieData('Automatiquement', countTA as double),
            PieData('Non Automatiquement', countNonTA as double),
          ];
        } else {
          int countSP = 0;
          int countNonSP = 0;
          weekSignalements.forEach((Signalement signalement) {
            if (signalement.signalementPertinant) {
              countSP += 1;
            } else {
              countNonSP += 1;
            }
          });
          return [
            PieData('Pertinent', countSP as double),
            PieData('Non Pertinent', countNonSP as double),
          ];
        }
      case 'Mois':
        // Filter signalements for this month
        DateTime now = DateTime.now();
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        DateTime endOfMonth =
            DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1));

        List<Signalement> monthSignalements = signalements
            .where((signalement) =>
                isWithinMonth(signalement.createdAt, startOfMonth, endOfMonth))
            .toList();
        if (titre == "Traité") {
          int countT = 0;
          int countNonT = 0;
          monthSignalements.forEach((Signalement signalement) {
            if (signalement.traite) {
              countT += 1;
            } else {
              countNonT += 1;
            }
          });
          return [
            PieData('Traité', countT as double),
            PieData('Non traité', countNonT as double),
          ];
        } else if (titre == "Traité Automatiquement") {
          int countTA = 0;
          int countNonTA = 0;
          monthSignalements.forEach((Signalement signalement) {
            if (signalement.traiteAutomatiquement) {
              countTA += 1;
            } else {
              countNonTA += 1;
            }
          });
          return [
            PieData('Automatiquement', countTA as double),
            PieData('Non Automatiquement', countNonTA as double),
          ];
        } else {
          int countSP = 0;
          int countNonSP = 0;
          monthSignalements.forEach((Signalement signalement) {
            if (signalement.signalementPertinant) {
              countSP += 1;
            } else {
              countNonSP += 1;
            }
          });
          return [
            PieData('Pertinent', countSP as double),
            PieData('Non Pertinent', countNonSP as double),
          ];
        }
      case 'Total':
        if (titre == "Traité") {
          int countT = 0;
          int countNonT = 0;
          signalements.forEach((Signalement signalement) {
            if (signalement.traite) {
              countT += 1;
            } else {
              countNonT += 1;
            }
          });
          return [
            PieData('Traité', countT as double),
            PieData('Non traité', countNonT as double),
          ];
        } else if (titre == "Traité Automatiquement") {
          int countTA = 0;
          int countNonTA = 0;
          signalements.forEach((Signalement signalement) {
            if (signalement.traiteAutomatiquement) {
              countTA += 1;
            } else {
              countNonTA += 1;
            }
          });
          return [
            PieData('Automatiquement', countTA as double),
            PieData('Non Automatiquement', countNonTA as double),
          ];
        } else {
          int countSP = 0;
          int countNonSP = 0;
          signalements.forEach((Signalement signalement) {
            if (signalement.signalementPertinant) {
              countSP += 1;
            } else {
              countNonSP += 1;
            }
          });
          return [
            PieData('Pertinent', countSP as double),
            PieData('Non Pertinent', countNonSP as double),
          ];
        }
      default:
        return [
          PieData('Traité', 1),
          PieData('Non traité', 1),
        ];
    }
  }
}

bool isToday(DateTime date, DateTime today) {
  return date.year == today.year &&
      date.month == today.month &&
      date.day == today.day;
}

bool isWithinWeek(DateTime date, DateTime startOfWeek, DateTime endOfWeek) {
  return date.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
      date.isBefore(endOfWeek.add(Duration(days: 1)));
}

bool isWithinMonth(DateTime date, DateTime startOfMonth, DateTime endOfMonth) {
  return date.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
      date.isBefore(endOfMonth.add(Duration(days: 1)));
}

class BarChartSection extends StatelessWidget {
  final String chartTitle;
  final List<OrdinalBar> chartData;

  BarChartSection({required this.chartTitle, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chartTitle,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
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

Widget _buildMostBannedWordsBarChart(List<BannedWord> bannedWords) {
  // Sort the bannedWords list based on usedCount in descending order
  bannedWords.sort((a, b) => b.usedCount.compareTo(a.usedCount));

  // Take the top five elements
  final topFiveWords = bannedWords.take(5).toList();

  return Column(
    children: [
      const Text(
        'Les mots les plus utilisés',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        height: 300.0,
        child: BarChartBannedWords(bannedWords: topFiveWords),
      ),
    ],
  );
}

Widget _buildLeastBannedWordsBarChart(List<BannedWord> bannedWords) {
  // Sort the bannedWords list based on usedCount in ascending order
  bannedWords.sort((a, b) => a.usedCount.compareTo(b.usedCount));

  // Take the first five elements (least used)
  final leastFiveWords = bannedWords.take(5).toList();

  return Column(
    children: [
      const Text(
        'Les mots les moins utilisés',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        height: 300.0,
        child: BarChartBannedWords(bannedWords: leastFiveWords),
      ),
    ],
  );
}
