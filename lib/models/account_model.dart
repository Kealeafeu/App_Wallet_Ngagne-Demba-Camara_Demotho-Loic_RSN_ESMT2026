class AccountModel {
  final int id;
  final int userId;
  final String currency;
  final double balance;

  AccountModel({
    required this.id,
    required this.userId,
    required this.currency,
    required this.balance,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      userId: json['userId'],
      currency: json['currency'],
      balance: (json['balance'] as num).toDouble(),
    );
  }
}