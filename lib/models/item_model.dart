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
    this.description,
    this.price,
    required this.quantity,
    required this.checked,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      createdAt: json["createdAt"] ?? "",  // Garantir que 'createdAt' nunca será null
      updatedAt: json["updatedAt"],        // Aceita null
      deletedAt: json["deletedAt"],        // Aceita null
      name: json["name"] ?? "",            // Garantir que 'name' nunca será null
      description: json["description"] ?? "", // Garantir que 'description' nunca será null
      price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,  // Valor padrão de 0.0
      quantity: int.tryParse(json["quantity"].toString()) ?? 0,  // Garantir que 'quantity' é um número válido
      checked: json["checked"] ?? false,   // Garantir que 'checked' seja booleano (false por padrão)
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
