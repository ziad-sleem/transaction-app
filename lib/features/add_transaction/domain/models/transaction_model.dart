class TransactionModel {
  final String? id; // nullable because Firebase handles it
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionCategory category;
  final String? note;

  TransactionModel({
    this.id, // optional
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    this.note,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json, String docId) {
    return TransactionModel(
      id: docId, // Firebase doc ID
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
      category: TransactionCategory.values.firstWhere(
        (e) => e.name == json['category'],
      ),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "date": date.toIso8601String(),
    "type": type.name,
    "category": category.name,
    "note": note,
  };
}

enum TransactionType { income, expense }

enum TransactionCategory {
  // expense
  food,
  travel,
  shopping,
  bills,
  health,
  entertainment,
  education,
  other,

  // income
  salary,
  bonus,
  freelancing,
  investment,
  gifts,
}

