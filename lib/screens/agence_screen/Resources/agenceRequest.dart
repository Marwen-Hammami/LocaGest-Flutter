class AgenceRequest {
  String agenceName;
  String adresse;
  double longitude; // Utilisation de double pour la latitude et la longitude
  double latitude;

  AgenceRequest({

    required this.agenceName,
    required this.adresse,
    required this.longitude,
    required this.latitude,
  });

  
  // Create a method to convert Agence object to JSON
  Map<String, dynamic> toJson() {
    return {
      'AgenceName': agenceName,
      'Adresse': adresse,
      'longitude': longitude,
      'latitude': latitude,
    };
  }


}
