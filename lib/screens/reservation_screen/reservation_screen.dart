import 'package:flutter/material.dart';
import 'package:locagest/providers/reservation_provider.dart';
import 'package:locagest/screens/reservation_screen/line_chart_sample2.dart';
import 'package:locagest/screens/reservation_screen/pie_chart_sample3.dart';
import 'package:locagest/screens/reservation_screen/line_chart_sample1.dart';
import 'package:locagest/services/reservations_service.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:locagest/models/reservation.dart';
import 'reservation_details_screen.dart';
import 'package:intl/intl.dart';
import 'calendar_screen.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key});

  // Fonction pour trouver les réservations pour une journée donnée
  List<Reservation> findReservationsForDay(
      DateTime day, List<Reservation> reservations) {
    return reservations.where((reservation) {
      return day.isAfter(
              reservation.DateDebut.subtract(const Duration(days: 1))) &&
          day.isBefore(reservation.DateFin.add(const Duration(days: 1)));
    }).toList();
  }

  // Fonction pour trouver les réservations par jour sur la période de validité
  Map<DateTime, List<Reservation>> findReservationsByDay(
      List<Reservation> reservations) {
    Map<DateTime, List<Reservation>> reservationsByDay = {};

    for (var reservation in reservations) {
      DateTime currentDay = reservation.DateDebut;
      while (currentDay.isBefore(reservation.DateFin.add(Duration(days: 1)))) {
        if (!reservationsByDay.containsKey(currentDay)) {
          reservationsByDay[currentDay] = [];
        }
        reservationsByDay[currentDay]!.add(reservation);
        currentDay = currentDay.add(Duration(days: 1));
      }
    }

    return reservationsByDay;
  }

  // Fonction pour naviguer vers les détails de la réservation
  void navigateToReservationDetails(BuildContext context, DateTime selectedDay,
      ReservationProvider reservationProvider) {
    Reservation selectedReservation = reservationProvider.reservations
        .firstWhere((reservation) =>
            selectedDay.isAfter(
                reservation.DateDebut.subtract(const Duration(days: 1))) &&
            selectedDay
                .isBefore(reservation.DateFin.add(const Duration(days: 1))));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ReservationDetailsScreen(selectedDay: selectedDay),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime firstDay = DateTime(today.year, today.month - 1, today.day);
    DateTime lastDay = DateTime(today.year + 1, today.month + 1, today.day);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Office - Reservations'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Statistiques
            Container(
              height: 450,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Statistiques sur le nombre total de réservations
                  Card(
                    elevation: 5,
                    color: Colors.lightBlueAccent,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        height: 200,
                        child: LineChartSample1(),
                      ),
                    ),
                  ),

                  // Statistiques sur le statut des réservations
                  Card(
                    elevation: 5,
                    color: Colors.orangeAccent,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        height: 200,
                        child: Consumer<ReservationProvider>(
                          builder: (context, reservationProvider, child) {
                            return PieChartSample3();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Calendrier
            TableCalendar(
              focusedDay: today,
              firstDay: firstDay,
              lastDay: lastDay,
              calendarFormat: CalendarFormat.month,
              eventLoader: (day) {
                var reservationProvider = context.watch<ReservationProvider>();
                return findReservationsByDay(
                        reservationProvider.reservations)[day] ??
                    [];
              },
              onDaySelected: (selectedDay, focusedDay) {
                var reservationProvider = context.read<ReservationProvider>();
                var reservationsForDay = findReservationsForDay(
                    selectedDay, reservationProvider.reservations);
                print('Reservations for $selectedDay: $reservationsForDay');
                navigateToReservationDetails(
                    context, selectedDay, reservationProvider);
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                cellMargin: EdgeInsets.all(4.0),
              ),
            ),

            // Filtrer par statut
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: 'Toutes',
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    context
                        .read<ReservationProvider>()
                        .updateSelectedStatut(newValue);
                  }
                },
                items: <String>['Toutes', 'Réservée', 'Payée', 'Achevée']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            // Liste des réservations
            Container(
              margin: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height * 0.5,
              child: FutureBuilder<List<Reservation>>(
                future: ReservationService()
                    .getAllReservations('http://localhost:9090'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Aucune réservation trouvée.');
                  } else {
                    List<Reservation> reservations = snapshot.data!;

                    String selectedStatut =
                        context.watch<ReservationProvider>().selectedStatut;

                    if (selectedStatut != 'Toutes') {
                      reservations = reservations
                          .where((reservation) =>
                              reservation.Statut == selectedStatut)
                          .toList();
                    }

                    return ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        Reservation reservation = reservations[index];
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          color: Colors.grey[200],
                          child: GestureDetector(
                            onTap: () {
                              navigateToReservationDetails(
                                context,
                                reservation.DateDebut,
                                context.read<ReservationProvider>(),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                'Date Début: ${DateFormat('yyyy-MM-dd').format(reservation.DateDebut)} ---> Date Fin: ${DateFormat('yyyy-MM-dd').format(reservation.DateFin)} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              subtitle: Text(
                                ' Statut: ${reservation.Statut} ',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
