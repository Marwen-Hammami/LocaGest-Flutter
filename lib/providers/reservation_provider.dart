import 'package:flutter/material.dart';
import 'package:locagest/models/reservation.dart';

class ReservationProvider extends ChangeNotifier {
  List<Reservation> reservations = [];

  ReservationProvider() {
    // Ajouter des réservations statiques lors de la création du provider
    addDummyReservation(
      dateDebut: DateTime.now(),
      dateFin: DateTime.now().add(Duration(days: 7)),
      heureDebut: '10:00',
      heureFin: '12:00',
      statut: 'Confirmé',
      total: 150.0,
    );

    addDummyReservation(
      dateDebut: DateTime.now().add(Duration(days: 1)),
      dateFin: DateTime.now().add(Duration(days: 8)),
      heureDebut: '14:00',
      heureFin: '16:00',
      statut: 'En attente',
      total: 200.0,
    );

    addDummyReservation(
      dateDebut: DateTime.now().add(Duration(days: 3)),
      dateFin: DateTime.now().add(Duration(days: 10)),
      heureDebut: '16:30',
      heureFin: '18:30',
      statut: 'Confirmé',
      total: 180.0,
    );
  }

  // Ajouter une réservation avec des paramètres spécifiés
  void addDummyReservation({
    DateTime? dateDebut,
    DateTime? dateFin,
    String heureDebut = '10:00',
    String heureFin = '12:00',
    String statut = 'Confirmé',
    double total = 150.0,
  }) {
    Reservation dummyReservation = Reservation(
      DateDebut: dateDebut ?? DateTime.now(),
      DateFin: dateFin ?? DateTime.now().add(Duration(days: 7)),
      HeureDebut: heureDebut,
      HeureFin: heureFin,
      Statut: statut,
      Total: total,
    );

    reservations.add(dummyReservation);

    // Notifie les auditeurs que la liste de réservations a été mise à jour
    notifyListeners();
  }
}
