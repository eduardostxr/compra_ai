import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ListProfileGroupHeader extends StatefulWidget {
  const ListProfileGroupHeader(
      {super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  State<ListProfileGroupHeader> createState() => _ListProfileGroupHeaderState();
}

class _ListProfileGroupHeaderState extends State<ListProfileGroupHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(
        16,
        16,
        0,
        16,
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          color: AppColors.darkGray,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
