class Medicine {
  final int id;
  final String name;
  final String description;
  final String pictureUrl;
  final double price;
  final String? sideEffects;
  final String? ingredients;
  final DateTime? expiryDate;
  int quantity;

  Medicine({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.price,
    this.sideEffects,
    this.ingredients,
    this.expiryDate,
    this.quantity = 1,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pictureUrl: json['picturUrl'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      sideEffects: json['sideEffects'],
      ingredients: json['ingredients'],
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
    );
  }
}
