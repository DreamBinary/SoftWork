import 'dart:io';
import 'dart:typed_data';

import 'package:account/app/component/my_header/crop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/toast.dart';
import 'header_state.dart';

class HeaderLogic extends GetxController {

  final HeaderState state = HeaderState();

  Future<Image?> getCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      return await crop(image);
    } else {
      ToastUtil.showToast("无照片");
      return null;
    }
  }

  Future<Image?> getGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return await crop(image);
    } else {
      ToastUtil.showToast("无照片");
      return null;
    }
  }

  Future<Image> crop(XFile xFile) async {
    Uint8List bytes =
        await Get.to(() => CropHeader(FileImage(File(xFile.path))));
    getPath(bytes);
    return Image.memory(bytes);
  }

  Future<void> getPath(Uint8List bytes) async {
    var tempDir = await getTemporaryDirectory();
    var file = await File(
            '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png')
        .create();
    file.writeAsBytesSync(bytes);
    state.path = file.path;
    // TODO
    // ApiUser.changeInfo(avatarPath: file.path);
  }

}
