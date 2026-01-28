class AccountDto {
  final int id;
  final int userId;
  final String currency;   // Exemple : "XOF", "USD", "BTC"
  final double balance;

  AccountDto({
    required this.id,
    required this.userId,
    required this.currency,
    required this.balance,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
      id: json['id'] as int,
      userId: json['userId'] as int,
      currency: json['currency'] as String,
      balance: (json['balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'currency': currency,
      'balance': balance,
    };
  }
}