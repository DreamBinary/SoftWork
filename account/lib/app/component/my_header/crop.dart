import 'package:flutter/material.dart';

// import 'package:head_image_cropper/head_image_cropper.dart';

import '../mytopbar.dart';

class CropHeader extends StatefulWidget {
  final ImageProvider image;

  const CropHeader(this.image, {super.key});

  @override
  State<CropHeader> createState() => _CropHeaderState();
}

class _CropHeaderState extends State<CropHeader> {
  // final CropperController _ctrl = CropperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
          trailing: IconButton(
              onPressed: () {
                // TODO
                // _ctrl.outImage().then((image) async {
                //   var bytes =
                //       (await (image.toByteData(format: ImageByteFormat.png)))
                //           ?.buffer
                //           .asUint8List();
                //   Get.back(result: bytes);
                // });
              },
              icon: const Icon(Icons.done_rounded))),
      body: SizedBox(),
    );
  }
}



// class _CropHeaderState extends State<CropHeader> {
//   // final CropperController _ctrl = CropperController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyTopBar(
//           trailing: IconButton(
//               onPressed: () {
//                 // TODO
//                 // _ctrl.outImage().then((image) async {
//                 //   var bytes =
//                 //       (await (image.toByteData(format: ImageByteFormat.png)))
//                 //           ?.buffer
//                 //           .asUint8List();
//                 //   Get.back(result: bytes);
//                 // });
//               },
//               icon: const Icon(Icons.done_rounded))),
//       body: CropperImage(
//         widget.image,
//         isArc: true,
//         controller: _ctrl,
//         // isArc: true,
//       ),
//     );
//   }
// }
