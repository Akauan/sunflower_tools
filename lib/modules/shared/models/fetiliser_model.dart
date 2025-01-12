class Fertiliser {
  String? name;
  int? fertilisedAt;
  int quantity;

  Fertiliser({
    this.name,
    this.fertilisedAt,
    this.quantity = 1,
  });

  factory Fertiliser.fromJson(Map<String, dynamic> json) {
    return Fertiliser(
      name: json['name'],
      fertilisedAt: json['fertilisedAt']?.toInt(), // Convert double to int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fertilisedAt': fertilisedAt,
    };
  }
}
