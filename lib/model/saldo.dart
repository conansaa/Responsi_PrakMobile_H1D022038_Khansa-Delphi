class Balance {
  int? id; // optional to support auto-incremented ID from the API
  String account;
  int balance;
  String status;

  Balance({
    this.id,
    required this.account,
    required this.balance,
    required this.status,
  });

  // Method to create a Balance object from JSON
  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      account: json['account'],
      balance: json['balance'],
      status: json['status'],
    );
  }

  // Method to convert a Balance object to JSON (e.g., for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account': account,
      'balance': balance,
      'status': status,
    };
  }
}