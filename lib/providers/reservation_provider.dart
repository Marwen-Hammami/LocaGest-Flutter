import 'package:flutter/material.dart';
import 'package:locagest/models/reservation.dart';
import 'package:locagest/services/reservations_service.dart';

class ReservationProvider extends ChangeNotifier {
  List<Reservation> reservations = [];

  Future<void> init() async {
    await loadReservations();
  }

  // Mettez à jour la méthode pour charger les réservations à partir du service
  Future<void> loadReservations() async {
    try {
      reservations = await ReservationService()
          .getAllReservations('http://localhost:9090');
      notifyListeners();
    } catch (e) {
      // Gérer les erreurs en fonction de votre cas d'utilisation
      print('Erreur lors du chargement des réservations: $e');
    }
  }
}
