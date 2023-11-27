import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mytopbar.dart';

class CropHeader extends StatefulWidget {
  final Uint8List image;

  const CropHeader(this.image, {super.key});

  @override
  State<CropHeader> createState() => _CropHeaderState();
}

class _CropHeaderState extends State<CropHeader> {
  final _ctrl = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
          trailing: IconButton(
              onPressed: () {
                _ctrl.crop();
              },
              icon: const Icon(Icons.done_rounded))),
      body: Crop(
        image: widget.image,
        controller: _ctrl,
        onCropped: (Uint8List value) {
          Get.back(result: value);
        },
      ),
    );
  }
}
