import 'package:compra/ui/new_list/components/emoji_input_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({super.key});

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final TextEditingController controller = TextEditingController();

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EmojiPicker(
          onEmojiSelected: (category, emoji) {
            setState(() {
              controller.text += emoji.emoji;
            });
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
        child: EmojiInputField(
          hint: "Ex: Amigos 123",
          label: "Nome",
          controller: controller,
          onEmojiPressed: _showEmojiPicker,
        ),
      ),
    );
  }
}
