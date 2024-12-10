import 'package:compra/models/complete_list_model.dart';
import 'package:flutter/material.dart';

class ListSummary extends StatelessWidget {
  final CompleteListModel completeListModel;

  const ListSummary({
    super.key,
    required this.completeListModel,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = completeListModel.totalPrice ?? 0;
    final userCount = completeListModel.userLists.length;
    final pricePerUser = totalPrice / (userCount + 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lista Encerrada',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        _buildOwnerInfo(),
        const SizedBox(height: 16),
        _buildPriceInfo(pricePerUser),
      ],
    );
  }

  Widget _buildOwnerInfo() {
    final owner = completeListModel.owner;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dono da Lista: ${owner.name}'),
        Text('Telefone: ${owner.telephone}'),
        Text('Chave PIX: ${owner.pixKey}'),
      ],
    );
  }

  Widget _buildPriceInfo(double pricePerUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preço Total: R\$ ${completeListModel.totalPrice?.toStringAsFixed(2)}'),
        Text('Valor por usuário: R\$ ${pricePerUser.toStringAsFixed(2)}'),
      ],
    );
  }
}
