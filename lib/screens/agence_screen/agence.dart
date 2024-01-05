class Agence {
  String id;
  String agenceName;
  String adresse;
  double longitude; // Utilisation de double pour la latitude et la longitude
  double latitude;

  Agence({
    required this.id,
    required this.agenceName,
    required this.adresse,
    required this.longitude,
    required this.latitude,
  });

  // Create a factory method to convert JSON to Agence object
  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(
      id: json['_id'],
      agenceName: json['AgenceName'],
      adresse: json['Adresse'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  // Create a method to convert Agence object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'AgenceName': agenceName,
      'Adresse': adresse,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
