import 'package:provider/provider.dart';
import 'package:locagest/providers/reservation_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:locagest/models/reservation.dart';
import 'reservation_details_screen.dart';
import 'package:flutter/material.dart';

class ReservationScreen extends StatelessWidget {
  List<Reservation> findReservationsForDay(
      DateTime day, List<Reservation> reservations) {
    // Utilisez la liste des réservations pour trouver les réservations pour la journée spécifiée
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendrier
            TableCalendar(
              focusedDay: today, // Date actuelle
              firstDay: firstDay,
              lastDay: lastDay,
              calendarFormat: CalendarFormat.month,
              eventLoader: (day) {
                // Utilisez la liste des réservations pour marquer les dates avec des événements
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
              // Autres paramètres du widget...
            ),

            // Liste des Réservations
            Container(
              // Ajout d'un Container pour définir des contraintes de hauteur
              height: MediaQuery.of(context).size.height * 0.5,
              // Ajustez la hauteur selon vos besoins
              child: Builder(
                builder: (context) {
                  var reservationProvider =
                      context.watch<ReservationProvider>();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: reservationProvider.reservations.length,
                    itemBuilder: (context, index) {
                      Reservation reservation =
                          reservationProvider.reservations[index];
                      return ListTile(
                        title: Text(
                            'Début: ${reservation.DateDebut} - Heure: ${reservation.HeureDebut}'),
                        subtitle: Text(
                            'Fin: ${reservation.DateFin} - Heure: ${reservation.HeureFin} | Statut: ${reservation.Statut} | Montant: ${reservation.Total}'),
                      );
                    },
                  );
                },
              ),
            ),

            // Ajouter une réservation factice lorsqu'un bouton est appuyé, par exemple
            ElevatedButton(
              onPressed: () {
                context.read<ReservationProvider>().addDummyReservation();
              },
              child: Text('Ajouter une réservation factice'),
            ),

            // Système de Notification
            //Text('Système de Notification: ...'),
          ],
        ),
      ),
    );
  }
}
