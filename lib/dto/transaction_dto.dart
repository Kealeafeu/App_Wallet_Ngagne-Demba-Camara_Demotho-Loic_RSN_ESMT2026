class TransactionDto {
  final int id;
  final int accountId;
  final String type;       // "credit" ou "debit"
  final double amount;
  final DateTime date;
  final String description;

  TransactionDto({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      id: json['id'] as int,
      accountId: json['accountId'] as int,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
    };
  }
}