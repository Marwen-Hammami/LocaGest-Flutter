
class HistoriqueEntretien {
  String immatriculation;
  String cartype;
  String titre;
  DateTime? dateEntretien;
  String description;
  double cout_reparation;
  String? image;

  HistoriqueEntretien({
    required this.immatriculation,
    required this.cartype,
    required this.titre,
    this.dateEntretien,
    required this.description,
    required this.cout_reparation,
    this.image,
  });

  factory HistoriqueEntretien.fromJson(Map<String, dynamic> json) {
    return HistoriqueEntretien(
      immatriculation: json['immatriculation'] ?? '',
      cartype: json['cartype'] ?? '',
      titre: json['titre'] ?? '',
      dateEntretien: DateTime.parse(json['date_entretien']),
      description: json['description'] ?? '',
      cout_reparation: json['cout_reparation']?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'immatriculation': immatriculation,
      
      'titre': titre,
      
      'description': description,
      'cout_reparation': cout_reparation,
      'image': image,
    };
  }
}
