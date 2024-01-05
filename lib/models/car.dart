class Car {
  final String immatriculation;
  final String marque;
  final String modele;
  final String? type;
  final String? carburant;
  final String? boite;
  final String? cylindree;
  final String? disponibility;
  final String? etatVoiture;
  final double? prixParJour;
  final String image;

  Car({
    required this.immatriculation,
    required this.marque,
    required this.modele,
    this.type,
    this.carburant,
    this.boite,
    this.cylindree,
    this.disponibility,
    this.etatVoiture,
    this.prixParJour,
    required this.image,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      immatriculation: json['immatriculation'] ?? '',
      marque: json['marque'] ?? '',
      modele: json['modele'] ?? '',
      type: json['type'],
      carburant: json['carburant'],
      boite: json['boite'],
      cylindree: json['cylindree'],
      disponibility: json['disponibility'],
      etatVoiture: json['etatVoiture'],
      prixParJour: json['prixParJour']?.toDouble(),
      image: json['image'] ?? '',
    );
  }
}
