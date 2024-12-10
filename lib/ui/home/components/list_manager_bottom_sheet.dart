import 'package:compra/ui/_common/custom_bottom_sheet.dart';
import 'package:compra/ui/_common/sheet_button.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ListManagerBottomSheet extends StatelessWidget {
  const ListManagerBottomSheet({
    super.key,
    required this.onDeleted,
    required this.onEdited,
    required this.onInvited,
  });
  final Function onDeleted;
  final Function onEdited;
  final Function onInvited;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: "Gerenciar Lista",
      children: [
        SheetButton(
          color: AppColors.darkGray,
          onPressed: () => onEdited(),
          icon: Icons.edit_outlined,
          label: "Editar lista",
        ),
        const SizedBox(height: 10),
        SheetButton(
          color: AppColors.darkGray,
          onPressed: () => onInvited(),
          icon: Icons.person_add_outlined,
          label: "Convidar amigos",
        ),
        const Divider(
          height: 32,
        ),
        SheetButton(
          color: AppColors.red,
          onPressed: () => onDeleted(),
          icon: Icons.delete_outline,
          label: "Deletar lista",
        ),
      ],
    );
  }
}
