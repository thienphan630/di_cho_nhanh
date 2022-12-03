import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:di_cho_nhanh/pages/homepage/widget/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({
    Key? key,
    required this.callback,
  }) : super(key: key);
  final Function(String) callback;
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? image;
  String base64Image = defaultImage;
  bool isLoadImage = false;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: image != null
            ? Image.file(
                image!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : Image.memory(
                base64Decode(base64Image),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
      ),
      ElevatedButton(
        onPressed: () async {
          await pickImage();
          final bytes = image!.readAsBytesSync();
          base64Image = base64Encode(bytes);
          widget.callback(base64Image);
        },
        child: const Text('Chọn ảnh'),
      ),
    ]);
  }
}

// Image.memory(
//                 base64Decode(base64Image!),
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               )