class AppUser {
  // user data
  final String userId;
  final String email;
  final String name;

  // transaction and balance data
  final double totalBalance;
  final double income;
  final double expense;

  AppUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.totalBalance,
    required this.income,
    required this.expense,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'name': name,
      'totalBalance': totalBalance,
      'income': income,
      'expense': expense,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> map) {
    return AppUser(
      userId: map['userId'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      totalBalance: (map['totalBalance'] as num?)?.toDouble() ?? 0.0,
      income: (map['income'] as num?)?.toDouble() ?? 0.0,
      expense: (map['expense'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
