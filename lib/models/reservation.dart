class Reservation {
  final DateTime DateDebut;
  final DateTime DateFin;
  final String HeureDebut;
  final String HeureFin;
  final String Statut;
  final double Total;

  Reservation({
    required this.DateDebut,
    required this.DateFin,
    required this.HeureDebut,
    required this.HeureFin,
    required this.Statut,
    required this.Total,
  });

 factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      DateDebut: DateTime.parse(json['DateDebut']),
      DateFin: DateTime.parse(json['DateFin']),
      HeureDebut: json['HeureDebut'],
      HeureFin: json['HeureFin'],
      Statut: json['Statut'],
      Total: json['Total'].toDouble(),
    );
  }
}
