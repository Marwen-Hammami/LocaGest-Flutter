import 'package:flutter/material.dart';
import 'package:locagest/models/reservation.dart';

class ReservationProvider extends ChangeNotifier {
  List<Reservation> reservations = [];
  String _selectedStatut = 'Toutes';

  String get selectedStatut => _selectedStatut;

  void updateSelectedStatut(String newStatut) {
    _selectedStatut = newStatut;
    notifyListeners();
  }


  // Ajouter une réservation avec des paramètres spécifiés
  void addReservation({
    required DateTime dateDebut,
    required DateTime dateFin,
    required String heureDebut,
    required String heureFin,
    required String statut,
    required double total,
  }) {
    Reservation newReservation = Reservation(
      DateDebut: dateDebut,
      DateFin: dateFin,
      HeureDebut: heureDebut,
      HeureFin: heureFin,
      Statut: statut,
      Total: total,
    );

    reservations.add(newReservation);

    // Notifie les auditeurs que la liste de réservations a été mise à jour
    notifyListeners();
  }
}
