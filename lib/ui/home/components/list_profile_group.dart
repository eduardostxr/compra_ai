import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/list_model.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_profile.dart';
import 'add_list_button.dart';

class ListProfileGroup extends StatefulWidget {
  const ListProfileGroup({
    super.key,
    required this.onProfileTap,
    required this.list
  });

  final Function(ListModel profile) onProfileTap;
  final List<ListModel> list;

  @override
  State<ListProfileGroup> createState() => ListProfileGroupState();
}

class ListProfileGroupState extends State<ListProfileGroup> {
  int? _selectedIndex;

  void _onProfileSelected(int index, List<ListModel> profiles) {
    setState(() {
      _selectedIndex = index;
    });

    widget.onProfileTap(profiles[index]);
  }

  void resetSelection() {
    setState(() {
      _selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListManager>(
      builder: (context, listManager, child) {
        final profiles = widget.list;
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
                  itemCount: profiles.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 6),
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return ListProfile(
                      title: profile.name,
                      emoji: profile.emoji,
                      isSelected: _selectedIndex == index,
                      onSelected: () => _onProfileSelected(index, profiles),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
