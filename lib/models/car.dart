class Car {
  String immatriculation;
  String marque;
  String modele;
  String? type;
  String? carburant;
  String? boite;
  String? cylindree;
  String? disponibility;
  String? etatVoiture;
  double? prixParJour;
  String image;

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

  Map<String, dynamic> toJson() {
    return {
      'immatriculation': immatriculation,
      'marque': marque,
      'modele': modele,
      
      'carburant': carburant,
      'boite': boite,
      
      
      'image': image,
    };
  }
}
