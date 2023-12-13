class BannedWord {
  String? id;
  String word;
  int usedCount;
  DateTime? createdAt;

  BannedWord({
    this.id,
    required this.word,
    required this.usedCount,
    this.createdAt,
  });

  factory BannedWord.fromJson(Map<String, dynamic> json) {
    return BannedWord(
      id: json['_id'],
      word: json['word'],
      usedCount: json['usedCount'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'word': word,
      'usedCount': usedCount,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
