import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/new_list/components/emoji_input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({super.key});

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<EmojiInputFieldState> emojiFieldKey = GlobalKey();

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EmojiPicker(
          onEmojiSelected: (category, emoji) {
            emojiFieldKey.currentState?.updateEmoji(emoji.emoji);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova lista"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EmojiInputField(
              key: emojiFieldKey,
              hint: "Ex: Amigos 123",
              label: "Nome",
              controller: controller,
              onEmojiPressed: _showEmojiPicker,
            ),
            const SizedBox(height: 32),
            DefaultButton(
                color: AppColors.darkGreen,
                label: "Criar Lista",
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
