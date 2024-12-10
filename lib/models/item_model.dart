class ItemModel {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;
  String? description;
  double? price;
  String name;
  double quantity;
  bool checked;

  ItemModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    this.description,
    this.price,
    required this.quantity,
    required this.checked,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"],  
      deletedAt: json["deletedAt"],    
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0, 
      quantity: double.tryParse(json["quantity"].toString()) ?? 0,  
      checked: json["checked"] ?? false,  
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
