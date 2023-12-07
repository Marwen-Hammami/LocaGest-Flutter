import 'package:flutter/material.dart';
import 'package:locagest/models/reservation.dart';
import 'package:locagest/providers/reservation_provider.dart';
import 'package:provider/provider.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final DateTime selectedDay; // Nouveau champ pour stocker la date sélectionnée

  ReservationDetailsScreen({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    // Récupérez la réservation correspondante à la date sélectionnée
    Reservation selectedReservation = context
        .watch<ReservationProvider>()
        .reservations
        .firstWhere((reservation) =>
            selectedDay.isAfter(
                reservation.DateDebut.subtract(Duration(days: 1))) &&
            selectedDay.isBefore(
                reservation.DateFin.add(Duration(days: 1))));

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Réservation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          // Utilisation de Card pour encadrer le contenu
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Début: ${selectedReservation.DateDebut} - Heure: ${selectedReservation.HeureDebut}',
                  style: TextStyle(fontSize: 18),
                ),
                Divider(),
                Text(
                  'Fin: ${selectedReservation.DateFin} - Heure: ${selectedReservation.HeureFin}',
                  style: TextStyle(fontSize: 18),
                ),
                Divider(),
                Text(
                  'Statut: ${selectedReservation.Statut}',
                  style: TextStyle(fontSize: 18),
                ),
                Divider(),
                Text(
                  'Montant: ${selectedReservation.Total}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
