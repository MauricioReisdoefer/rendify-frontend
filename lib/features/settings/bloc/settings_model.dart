class SettingsUser {
  final int id;
  final String name;
  final double balance;

  SettingsUser({
    required this.id,
    required this.name,
    required this.balance,
  });

  factory SettingsUser.fromJson(Map<String, dynamic> json) {
    return SettingsUser(
      id: json["id"],
      name: json["name"],
      balance: (json["balance"] as num).toDouble(),
    );
  }
}