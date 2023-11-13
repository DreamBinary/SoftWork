// import 'package:account/app/component/refresh_indicator.dart';
// import 'package:account/app/routes/app_pages.dart';
// import 'package:account/app/utils/toast.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import '../theme/app_colors.dart';
// import '../theme/app_string.dart';
// import '../utils/mmkv.dart';
// import 'cropImg.dart';
// import 'loading_page.dart';
//
// class CroppingPage extends StatelessWidget {
//   final String fileName;
//   final bool isScreenShot;
//
//   const CroppingPage(
//       {required this.fileName, this.isScreenShot = false, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: ApiImg.getModifyUrl(fileName: fileName),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return CropImg(
//             image: Image.network(
//               snapshot.data!,
//               headers: {"token": MMKVUtil.getString(AppString.mmToken)},
//             ),
//             onCropped: (Image image, String path) async {
//               List<String> urls = await ApiImg.upImg(imgPaths: [path]);
//               try {
//                 fun() async {
//                   ConsumeData? cData;
//                   if (isScreenShot) {
//                     cData = await ApiImg.getScreenRecognizeResult(
//                         fileName: urls[0].split('/').last);
//                   } else {
//                     cData = await ApiImg.getRecognizeResult(
//                         fileName: urls[0].split('/').last);
//                   }
//                   cData?.imgUrl = urls[0];
//                   return cData;
//                 }
//
//                 Get.to(LoadingPage(future: fun()))?.then(
//                     (value) => Get.toNamed(Routes.add, arguments: value));
//               } catch (e) {
//                 ToastUtil.showToast("识别失败，请重试");
//               }
//             },
//           );
//         }
//         return const Scaffold(
//           body: Center(
//             child: MyRefreshIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }