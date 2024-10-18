import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'list_profile.dart';
import 'add_list_button.dart';

class ListProfileGroup extends StatefulWidget {
  const ListProfileGroup({super.key, required this.profiles});

  final List<Map<String, dynamic>> profiles;

  @override
  State<ListProfileGroup> createState() => _ListProfileGroupState();
}

class _ListProfileGroupState extends State<ListProfileGroup> {
  int? _selectedIndex;

  void _onProfileSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        color: AppColors.offWhite,
      ),
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.profiles.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const AddListButton();
          } else {
            final profile = widget.profiles[index - 1];
            return ListProfile(
              title: profile['title'],
              emoji: profile['emoji'],
              isSelected: _selectedIndex == index - 1,
              onSelected: () => _onProfileSelected(index - 1),
            );
          }
        },
      ),
    );
  }
}
