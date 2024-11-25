import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'list_profile.dart';
import 'add_list_button.dart';

class ListProfileGroup extends StatefulWidget {
  const ListProfileGroup({
    super.key,
    required this.profiles,
    required this.onProfileTap,
  });

  final List<Map<String, dynamic>> profiles;
  final Function(int index, Map<String, dynamic> profile) onProfileTap;

  @override
  State<ListProfileGroup> createState() => _ListProfileGroupState();
}

class _ListProfileGroupState extends State<ListProfileGroup> {
  int? _selectedIndex;

  void _onProfileSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Chamar a função passada do widget pai
    widget.onProfileTap(index, widget.profiles[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        color: AppColors.offWhite,
      ),
      height: 100,
      child: Row(
        children: [
          const AddListButton(),
          const SizedBox(width: 6),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.profiles.length,
              separatorBuilder: (context, index) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final profile = widget.profiles[index];
                return ListProfile(
                  title: profile['title'],
                  emoji: profile['emoji'],
                  isSelected: _selectedIndex == index,
                  onSelected: () => _onProfileSelected(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
