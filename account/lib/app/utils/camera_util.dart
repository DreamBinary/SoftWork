import 'dart:io';
import 'dart:typed_data';

import 'package:account/app/utils/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraUtil {
  static Future<XFile?> getCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      return image;
    } else {
      ToastUtil.showToast("无照片");
      return null;
    }
  }

  // static Future<dynamic> getCamera(Function(XFile) processImage) async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     return await processImage(image);
  //   } else {
  //     ToastUtil.showToast("无照片");
  //     return null;
  //   }
  // }

  // static Future<dynamic> getGallery(Function(XFile) processImage) async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     return await processImage(image);
  //   } else {
  //     ToastUtil.showToast("无照片");
  //     return null;
  //   }
  // }

  static Future<XFile?> getGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image;
    } else {
      ToastUtil.showToast("无照片");
      return null;
    }
  }

  static Future<List<String>> upImg(XFile xFile) async {
    // String path = xFile.path;
    // File file = File(path);
    // List<String> urls = await ApiImg.upImg(imgPaths: [file.path]);
    // file.deleteSync(recursive: true);
    // return urls;
    // TODO
    var urls = ["1"];
    return urls;
  }

  static Future<String> getPath(Uint8List bytes) async {
    var tempDir = await getTemporaryDirectory();
    var file = await File(
        '${tempDir.path}/image_${DateTime
            .now()
            .millisecondsSinceEpoch}.png')
        .create();
    file.writeAsBytesSync(bytes);
    return file.path;
  }
}
