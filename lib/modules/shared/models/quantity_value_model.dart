class QuantityValue {
  int quantity;
  double value;

  QuantityValue({required this.quantity, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'value': value,
    };
  }
}
