import 'dart:io';

import 'package:account/app/utils/camera_util.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as bdg;
import '../../theme/app_colors.dart';
import '../../theme/app_string.dart';
import '../../theme/app_text_theme.dart';
import '../image_preview.dart';
import 'header_logic.dart';

class HeaderComponent extends StatefulWidget {
  final Widget? child;
  final bool showAdd;
  final double radius;
  final GestureTapCallback? onTap;

  const HeaderComponent(
      {this.radius = 50,
      this.onTap,
      this.child,
      this.showAdd = false,
      super.key});

  @override
  _HeaderComponentState createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  final logic = Get.find<HeaderLogic>();
  final state = Get.find<HeaderLogic>().state;
  late dynamic _child;

  @override
  void initState() {
    super.initState();
    _child = widget.child ?? Image.asset(AssetsRes.P0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ??
          () {
            Get.to(ImagePreview(_child.image));
          },
      child: bdg.Badge(
        badgeContent: GestureDetector(
          onTap: _showChoice,
          child: const Icon(Icons.add),
        ),
        badgeColor: AppColors.grey,
        alignment: Alignment.topRight,
        elevation: 10,
        showBadge: widget.showAdd,
        child: Hero(
          tag: "header",
          child: Container(
            height: widget.radius * 2,
            width: widget.radius * 2,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            foregroundDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: _child,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showChoice() {
    return Platform.isIOS
        // iphone
        ? showCupertinoModalPopup(
            context: context,
            builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: _getCamera,
                  child: Text(AppString.camera, style: AppTS.big),
                ),
                CupertinoActionSheetAction(
                  onPressed: _getGallery,
                  child: Text(AppString.gallery, style: AppTS.big),
                ),
              ],
            ),
          )
        // android
        : showModalBottomSheet(
            context: context,
            builder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _sheetItem(onPressed: _getCamera, text: AppString.camera),
                const Divider(),
                _sheetItem(onPressed: _getGallery, text: AppString.gallery),
              ],
            ),
          );
  }

  void _getGallery() {
    Get.back();
    logic.getGallery().then((value) => {
          if (value != null)
            {
              setState(
                () {
                  _child = value;
                },
              )
            }
        });
  }

  void _getCamera() {
    Get.back();
    logic.getCamera().then(
          (value) => {
            if (value != null)
              {
                setState(
                  () {
                    _child = value;
                  },
                )
              }
          },
        );
  }

  Widget _sheetItem({required VoidCallback onPressed, required String text}) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTS.big,
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HeaderLogic>();
    super.dispose();
  }
}
