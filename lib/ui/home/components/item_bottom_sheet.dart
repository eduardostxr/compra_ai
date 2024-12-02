import 'package:compra/ui/_common/custom_bottom_sheet.dart';
import 'package:compra/ui/_common/sheet_button.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ItemBottomSheet extends StatelessWidget {
  const ItemBottomSheet({
    super.key,
    required this.title,
    required this.onDeleted,
    required this.onEdited,
  });

  final String title;
  final Function onDeleted;
  final Function onEdited;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: title,
      children: [
        SheetButton(
            color: AppColors.darkGray,
            onPressed: () => onEdited(),
            icon: Icons.edit_outlined,
            label: "Editar"),
        const SizedBox(height: 10),
        SheetButton(
            color: AppColors.red,
            onPressed: () => onDeleted(),
            icon: Icons.exit_to_app_outlined,
            label: "Deletar"),
      ],
    );
  }
}
