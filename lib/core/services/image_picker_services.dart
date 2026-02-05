import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImageFromGallery(BuildContext context) async {
    final status = await Permission.photos.request();

    if (status.isDenied || status.isPermanentlyDenied) {
      Navigator.of(context).pop();
      return null;
    }

    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    return File(image.path);
  }
}
