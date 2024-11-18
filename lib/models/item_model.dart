class ItemModel {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final bool checked;

  ItemModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.checked,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      checked: json['checked'],
    );
  }
}