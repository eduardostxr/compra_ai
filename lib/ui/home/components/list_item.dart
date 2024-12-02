import 'package:compra/models/item_model.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  // final String name;
  // final bool isChecked;
  final ItemModel item;
  final VoidCallback onInfoPressed;
  final VoidCallback onMorePressed;
  final ValueChanged<bool> onChecked;

  const ListItem({
    super.key,
    // required this.name,
    // this.isChecked = false,
    required this.item,
    required this.onInfoPressed,
    required this.onMorePressed,
    required this.onChecked,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.item.checked;
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
    widget.onChecked(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      height: 45,
      decoration: BoxDecoration(
        color: isChecked ? AppColors.lightPeach : AppColors.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              side: BorderSide.none,
              fillColor: WidgetStateProperty.all(AppColors.gray),
              value: isChecked,
              checkColor: AppColors.orange,
              onChanged: _toggleCheckbox,
            ),
          ),
          Expanded(
            child: Text(
              widget.item.name,
              style: TextStyle(
                fontSize: 16,
                color: isChecked ? AppColors.mediumGray : AppColors.darkGray,
                decoration: isChecked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          widget.item.description != null ?
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: widget.onInfoPressed,
            color: isChecked ? AppColors.mediumGray : AppColors.darkGray,
          ) : const SizedBox(),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: widget.onMorePressed,
            color: isChecked ? AppColors.mediumGray : AppColors.darkGray,
          ),
        ],
      ),
    );
  }
}
