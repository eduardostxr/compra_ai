import 'dart:io';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  String userName = "Usuário";
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool _isImageSelected = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _image = pickedFile;
      _isImageSelected = pickedFile != null;
    });
  }

  Future<void> _sendImage() async {
    // if (_image == null) return;

    // final request = http.MultipartRequest(
    //   'POST',
    //   Uri.parse('YOUR_API_ENDPOINT_HERE'),
    // );
    // request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    // final response = await request.send();

    // if (response.statusCode == 200) {
    //   // Handle successful response
    //   print('Image uploaded successfully');
    // } else {
    //   // Handle error response
    //   print('Image upload failed');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: Row(
          children: [
            Text(
              "Olá, $userName!",
              textAlign: TextAlign.left,
              style: const TextStyle(color: AppColors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Tirar foto'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Selecionar da galeria'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: _isImageSelected ? _sendImage : null,
                  child: const Text('Enviar Foto'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
