import 'package:compra/models/item_model.dart';
import 'package:compra/ui/_common/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ItemDescriptionBottomSheet extends StatelessWidget {
  const ItemDescriptionBottomSheet({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: item.name,
      children: [
        Text(item.description!),
        const SizedBox(height: 16),
      ],
    );
  }
}
