class ProductModel {
  final String nome;
  final int quantidade;
  final double precoTotal;
  final double precoUnidade;
  final String unidadeMedida;

  ProductModel({
    required this.nome,
    required this.quantidade,
    required this.precoTotal,
    required this.precoUnidade,
    required this.unidadeMedida,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      nome: json['nome'] ?? '',
      quantidade: json['quantidade'] ?? 0,
      precoTotal: (json['preco_total'] as num).toDouble(),
      precoUnidade: (json['preco_unidade'] as num).toDouble(),
      unidadeMedida: json['unidade_medida'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'quantidade': quantidade,
      'preco_total': precoTotal,
      'preco_unidade': precoUnidade,
      'unidade_medida': unidadeMedida,
    };
  }
}

class ReceiptModel {
  final int userId;
  final List<ProductModel> produtos;
  final double precoTotalCompra;
  final String dataCompra;

  ReceiptModel({
    required this.userId,
    required this.produtos,
    required this.precoTotalCompra,
    required this.dataCompra,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      userId: json['userId'] ?? 0,
      produtos: (json['response']['produtos'] as List<dynamic>)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
      precoTotalCompra:
          (json['response']['preco_total_compra'] as num).toDouble(),
      dataCompra: json['response']['data_compra'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'response': {
        'produtos': produtos.map((item) => item.toJson()).toList(),
        'preco_total_compra': precoTotalCompra,
        'data_compra': dataCompra,
      },
    };
  }
}
