import 'package:compra/models/item_model.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onInfoPressed;
  final VoidCallback onMorePressed;
  final VoidCallback onChecked;

  const ListItem({
    super.key,
    required this.item,
    required this.onInfoPressed,
    required this.onMorePressed,
    required this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      height: 45,
      decoration: BoxDecoration(
        color: item.checked ? AppColors.lightPeach : AppColors.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              side: BorderSide.none,
              fillColor: WidgetStateProperty.all(AppColors.gray),
              value: item.checked,
              checkColor: AppColors.orange,
              onChanged: (_) => onChecked(),
            ),
          ),
          Expanded(
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 16,
                color: item.checked ? AppColors.mediumGray : AppColors.darkGray,
                decoration: item.checked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          item.description != null
              ? IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: onInfoPressed,
                  color: item.checked ? AppColors.mediumGray : AppColors.darkGray,
                )
              : const SizedBox(),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: onMorePressed,
            color: item.checked ? AppColors.mediumGray : AppColors.darkGray,
          ),
        ],
      ),
    );
  }
}
