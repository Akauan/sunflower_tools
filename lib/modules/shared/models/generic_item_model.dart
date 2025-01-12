class Item {
  int? amount;
  String? name;

  Item({this.amount, this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      amount: json['amount']?.toInt(), // Convert double to int
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'name': name,
    };
  }
}
