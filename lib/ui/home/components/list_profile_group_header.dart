import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ListProfileGroupHeader extends StatefulWidget {
  const ListProfileGroupHeader({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<ListProfileGroupHeader> createState() => _ListProfileGroupHeaderState();
}

class _ListProfileGroupHeaderState extends State<ListProfileGroupHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        start: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Minhas listas"),
          Row(
            children: [
              TextButton(
                onPressed: widget.onPressed,
                style:
                    TextButton.styleFrom(foregroundColor: AppColors.mediumGray),
                child: const Row(
                  children: [
                    Text("Ver todas"),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
