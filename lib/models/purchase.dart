class Purchase {
  final int userId;
  final Payload payload;

  Purchase({
    required this.userId,
    required this.payload,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      userId: json['userId'],
      payload: Payload.fromJson(json['payload']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'payload': payload.toJson(),
    };
  }
}

class Payload {
  final List<Product> produtos;
  final double listTotalPrice;
  final String purchaseDate;

  Payload({
    required this.produtos,
    required this.listTotalPrice,
    required this.purchaseDate,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      produtos: (json['produtos'] as List)
          .map((produto) => Product.fromJson(produto))
          .toList(),
      listTotalPrice: json['listTotalPrice'].toDouble(),
      purchaseDate: json['purchaseDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'produtos': produtos.map((produto) => produto.toJson()).toList(),
      'listTotalPrice': listTotalPrice,
      'purchaseDate': purchaseDate,
    };
  }
}

class Product {
  final String name;
  final double quantity;
  final double price;
  final double unitPrice;
  final String measurementUnit;

  Product({
    required this.name,
    required this.quantity,
    required this.price,
    required this.unitPrice,
    required this.measurementUnit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      quantity: json['quantity'].toDouble(),
      price: json['price'].toDouble(),
      unitPrice: json['unitPrice'].toDouble(),
      measurementUnit: json['measurementUnit'] ?? 'UN',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'unitPrice': unitPrice,
      'measurementUnit': measurementUnit,
    };
  }
}
