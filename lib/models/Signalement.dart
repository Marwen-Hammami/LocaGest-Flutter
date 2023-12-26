class Signalement {
  String id;
  String messageId;
  String signaleurId;
  String raison;
  String raisonAutre;
  bool traite;
  bool traiteAutomatiquement;
  bool signalementPertinant;
  DateTime createdAt;
  DateTime updatedAt;

  Signalement({
    required this.id,
    required this.messageId,
    required this.signaleurId,
    required this.raison,
    required this.raisonAutre,
    required this.traite,
    required this.traiteAutomatiquement,
    required this.signalementPertinant,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Signalement.fromJson(Map<String, dynamic> json) {
    return Signalement(
      id: json['_id'] ?? '',
      messageId: json['messageId'] ?? '',
      signaleurId: json['signaleurId'] ?? '',
      raison: json['raison'] ?? 'Harcèlement',
      raisonAutre: json['raisonAutre'] ?? '',
      traite: json['traite'] ?? false,
      traiteAutomatiquement: json['traiteAutomatiquement'] ?? false,
      signalementPertinant: json['signalementPertinant'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'messageId': messageId,
      'signaleurId': signaleurId,
      'raison': raison,
      'raisonAutre': raisonAutre,
      'traite': traite,
      'traiteAutomatiquement': traiteAutomatiquement,
      'signalementPertinant': signalementPertinant,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
