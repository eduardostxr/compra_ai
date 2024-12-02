class ItemModel {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;
  String? description;
  double? price;
  String name;
  int quantity;
  bool checked;

  ItemModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    required this.description,
    this.price,
    required this.quantity,
    required this.checked,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      deletedAt: json["deletedAt"],
      name: json["name"],
      description: json["description"],
      price: json["price"] != null ? (json["price"] as num).toDouble() : null,
      quantity: json["quantity"],
      checked: json["checked"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "description": description,
      "price": price,
      "quantity": quantity,
      "checked": checked,
    };

    if (id != 0) {
      data["id"] = id;
    }

    return data;
  }
}
