import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/theme/app_string.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/mmkv.dart';
import 'package:account/res/assets_res.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import 'color_view.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  bool openLock = MMKVUtil.getBool(AppString.mmOpenLock);
  String currency = MMKVUtil.getString(AppString.mmCurrency);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: Text(
          "个性化",
          style: AppTS.normal,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingContain(
            dividerColor: AppColors.color_list[2],
            items: [
              SettingItemOpen(
                  title: "主题",
                  imgPath: AssetsRes.SETTING_ICON0,
                  openBuilder: (context, action) => ColorView(),
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                  )),
              SettingItem(
                imgPath: AssetsRes.SETTING_ICON1,
                title: "账本密码",
                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(15)),
                ),
                trailing: Switch(
                  value: openLock,
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.color_list[2],
                  onChanged: (value) {
                    MMKVUtil.put(AppString.mmOpenLock, value);
                    setState(
                      () {
                        openLock = value;
                      },
                    );
                  },
                ),
              ),
              // SettingItemOpen(
              //   imgPath: AssetsRes.SETTING_ICON2,
              //   title: "货币",
              //   trailing: Padding(
              //     padding: const EdgeInsets.only(right: 10),
              //     child: Text(
              //       currency == "" ? "人民币" : currency,
              //       style: AppTS.small.copyWith(color: Colors.grey),
              //     ),
              //   ),
              //   shape: const RoundedRectangleBorder(
              //     borderRadius:
              //         BorderRadius.vertical(bottom: Radius.circular(15)),
              //   ),
              //   openBuilder: (BuildContext context,
              //       void Function({dynamic returnValue}) action) {
              //     return CurrencyPage(
              //       onSelect: (value) {
              //         MMKVUtil.put(AppString.mmCurrency, value);
              //         setState(() {
              //           currency = value;
              //         });
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final String imgPath;
  final ShapeBorder? shape;
  final GestureTapCallback? onTap;
  final Widget? trailing;

  const SettingItem(
      {Key? key,
      required this.title,
      required this.imgPath,
      this.shape,
      this.onTap,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: shape,
      leading: Image.asset(imgPath, height: 35.w, width: 35.w),
      title: Text(
        title,
        style: AppTS.normal,
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class SettingItemOpen extends SettingItem {
  final OpenContainerBuilder openBuilder;

  const SettingItemOpen(
      {super.key,
      required super.title,
      required super.imgPath,
      super.shape,
      super.trailing,
      required this.openBuilder});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedElevation: 0,
        closedShape: super.shape ?? const RoundedRectangleBorder(),
        closedBuilder: (context, action) => super.build(context),
        openBuilder: openBuilder);
  }
}

class SettingContain extends StatelessWidget {
  final List<SettingItem> items;
  final List<Widget> children = [];
  final Color? dividerColor;

  SettingContain({required this.items, this.dividerColor, Key? key})
      : super(key: key) {
    for (int i = 0; i < items.length; i++) {
      children.add(items[i]);
      if (i != items.length - 1) {
        children.add(
          Divider(
            height: 0,
            indent: 15,
            endIndent: 15,
            thickness: 0.8,
            color: dividerColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
