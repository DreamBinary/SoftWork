import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/camera_util.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CropImg extends StatefulWidget {
  final Image image;
  final Function(Image image, String path) onCropped;

  const CropImg({required this.image, required this.onCropped, Key? key})
      : super(key: key);

  @override
  State<CropImg> createState() => _CropImgState();
}

class _CropImgState extends State<CropImg> {
  final _ctrl = CropController();

  late Image image = widget.image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        middle: Text(
          "裁剪图片",
          style: AppTS.normal,
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: AppColors.color_list[5]),
          onPressed: () => _cropImage(),
          child: Text("裁剪上传",
              style: AppTS.small.copyWith(
                  color: AppColors.textColor(AppColors.color_list[5]))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: CropImage(
            controller: _ctrl, image: image, touchSize: 80, alwaysMove: true),
      ),
    );
  }

  Future<void> _cropImage() async {
    Image img = await _ctrl.croppedImage();

    ui.Image bitmap = await _ctrl.croppedBitmap();
    ByteData? data = await bitmap.toByteData(format: ui.ImageByteFormat.png);
    Uint8List bytes = data!.buffer.asUint8List();
    String path = await CameraUtil.getPath(bytes);

    widget.onCropped(img, path);
  }
}
