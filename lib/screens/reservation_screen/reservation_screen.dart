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
import 'reservation_statistics_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatelessWidget {
  List<Reservation> findReservationsForDay(
      DateTime day, List<Reservation> reservations) {
    return reservations.where((reservation) {
      return day.isAfter(reservation.DateDebut.subtract(Duration(days: 1))) &&
          day.isBefore(reservation.DateFin.add(Duration(days: 1)));
    }).toList();
  }

  void navigateToReservationDetails(BuildContext context, DateTime selectedDay,
      ReservationProvider reservationProvider) {
    Reservation selectedReservation = reservationProvider.reservations
        .firstWhere((reservation) =>
            selectedDay
                .isAfter(reservation.DateDebut.subtract(Duration(days: 1))) &&
            selectedDay.isBefore(reservation.DateFin.add(Duration(days: 1))));

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
      appBar: AppBar(title: Text('Reservations')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Diagramme statistique
            // ReservationStatisticsChart(),

            // Ajouter des statistiques
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Statistiques sur le nombre total de réservations
                  Text(
                    'Statistiques sur le nombre total de réservations',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Mukta'),
                  ),
                  LineChartSample1(),

                  // Statistiques sur les revenus générés par les réservations
                  Text(
                    'Statistiques sur les revenus générés par les réservations',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Mukta'),
                  ),
                  LineChartSample2(),

                  // Statistiques sur le statut des réservations
                  Text(
                    'Statistiques sur le statut des réservations',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Mukta'),
                  ),
                  PieChartSample3(),
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
                return findReservationsForDay(
                    day, reservationProvider.reservations);
              },
              onDaySelected: (selectedDay, focusedDay) {
                var reservationProvider = context.read<ReservationProvider>();
                var reservationsForDay = findReservationsForDay(
                    selectedDay, reservationProvider.reservations);
                print('Reservations for $selectedDay: $reservationsForDay');
                navigateToReservationDetails(
                    context, selectedDay, reservationProvider);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                cellMargin: EdgeInsets.all(4.0),
                //style
              ),
            ),

            // Liste des Réservations
            Container(
              margin: EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height * 0.5,
              child: FutureBuilder<List<Reservation>>(
                future: ReservationService()
                    .getAllReservations('http://192.168.140.1:9090'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Aucune réservation trouvée.');
                  } else {
                    List<Reservation> reservations = snapshot.data!;
                    return ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        Reservation reservation = reservations[index];
                        return Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(
                              'Date Début: ${DateFormat('yyyy-MM-dd').format(reservation.DateDebut)} ---> Date Fin: ${DateFormat('yyyy-MM-dd').format(reservation.DateFin)} ',
                            ),
                            subtitle: Text(
                              ' Statut: ${reservation.Statut} ',
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
