class TransactionModel {
  final int id;
  final int accountId;
  final String type;
  final double amount;
  final DateTime date;
  final String description;

  TransactionModel({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      accountId: json['accountId'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      description: json['description'],
    );
  }
}