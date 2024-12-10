class ItemModel {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  String? description;
  double price;
  String name;
  String quantity;
  bool checked;
  double unitPrice;
  String measurementUnit;

  ItemModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    this.description,
    required this.price,
    required this.quantity,
    required this.checked,
    required this.unitPrice,
    required this.measurementUnit,
  });

factory ItemModel.fromJson(Map<String, dynamic> json) {
  return ItemModel(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    deletedAt: json["deletedAt"] != null ? DateTime.parse(json["deletedAt"]) : null,
    name: json["name"] ?? "",
    description: json["description"],
    price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,
    quantity: json["quantity"]?.toString() ?? "0", // Tratamento para String
    checked: json["checked"] ?? false,
    unitPrice: json["unitPrice"] != null ? (json["unitPrice"] as num).toDouble() : 0.0,
    measurementUnit: json["measurementUnit"] ?? "",
  );
}


  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "description": description,
      "price": price,
      "quantity": quantity,
      "checked": checked,
      "unitPrice": unitPrice,
      "measurementUnit": measurementUnit,
    };

    if (id != 0) {
      data["id"] = id;
    }

    data["createdAt"] = createdAt.toIso8601String();
    if (updatedAt != null) {
      data["updatedAt"] = updatedAt?.toIso8601String();
    }
    if (deletedAt != null) {
      data["deletedAt"] = deletedAt?.toIso8601String();
    }

    return data;
  }
}
