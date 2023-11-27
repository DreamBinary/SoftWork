import 'package:account/app/component/mycard.dart';
import 'package:account/app/component/myshimmer.dart';
import 'package:account/app/component/myshowbottomsheet.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../data/net/api_guardian.dart';
import '../../../../utils/toast.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: Text('邀请成员', style: AppTS.normal),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                PhysicalModel(
                  elevation: 5,
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 147.h,
                    width: 108.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AssetsRes.BOOK0),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 140.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text('我的日常', style: AppTS.normal),
                      const SizedBox(height: 10),
                      Text('账本主人：啊哈哈哈',
                          style: AppTS.small
                              .copyWith(color: AppColors.color_list[5])),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('邀请编码有效期', style: AppTS.normal),
                  Text('7天', style: AppTS.normal),
                ],
              ),
            ),
            const _InviteItem(
              title: '免审核，成为指定角色',
              content: '设置角色，加入账本时自动成为该角色，无需审核。',
            ),
            SizedBox(height: 15.h),
            const _InviteItem(
              title: '审核后加入账本',
              content: '管理员账本主人或管理员审核后，可加入账本。',
            ),
            SizedBox(height: 15.h),
            _InviteItem(
              title: '免审核，输入邀请码加入',
              content: '成员加入账本时输入邀请码，即可成为对应角色。',
              onPressed: () {
                myShowBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 300.h,
                      child: Column(
                        children: [
                          Container(
                              height: 120.h,
                              width: double.infinity,
                              color: AppColors.color_list[2],
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("邀请编码有效期     24小时",
                                      style: AppTS.big),
                                  Text("超过分享有效期后，邀请码将失效",
                                      style: AppTS.small.copyWith(
                                          color: AppColors.color_list[5])),
                                ],
                              )),
                          FutureBuilder(
                            future: ApiGuardian.getCode(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                String code = snapshot.data ?? "&AJ9L0HW";
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 20),
                                    DottedBorder(
                                      padding: const EdgeInsets.all(10),
                                      radius: const Radius.circular(10),
                                      borderType: BorderType.RRect,
                                      child: Text(
                                        code,
                                        style: AppTS.big32.copyWith(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 3),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        const SizedBox(width: 30),
                                        Expanded(
                                          child: MaterialButton(
                                            shape: const StadiumBorder(),
                                            color: AppColors.color_list[2],
                                            onPressed: () {
                                              FlutterClipboard.copy(
                                                  "邀请码:$code");
                                              ToastUtil.showToast(
                                                  "复制到剪切板");
                                            },
                                            child:
                                            Text('复制', style: AppTS.normal),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: MaterialButton(
                                            shape: const StadiumBorder(),
                                            color: AppColors.color_list[2],
                                            onPressed: () async {
                                              await Share.share("邀请码: $code",
                                                  subject: code);
                                            },
                                            child:
                                            Text('分享', style: AppTS.normal),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return ShimmerEffect(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 20),
                                      DottedBorder(
                                        padding: const EdgeInsets.all(10),
                                        radius: const Radius.circular(10),
                                        borderType: BorderType.RRect,
                                        child: Text(
                                          "AJ9L0HWU",
                                          style: AppTS.big32.copyWith(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 3),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          const SizedBox(width: 30),
                                          Expanded(
                                            child: MaterialButton(
                                              shape: const StadiumBorder(),
                                              color: AppColors.color_list[2],
                                              onPressed: () {},
                                              child: Text('复制',
                                                  style: AppTS.normal),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: MaterialButton(
                                              shape: const StadiumBorder(),
                                              color: AppColors.color_list[2],
                                              onPressed: () {},
                                              child: Text('分享',
                                                  style: AppTS.normal),
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteItem extends StatelessWidget {
  final String title;
  final String content;
  final GestureTapCallback? onPressed;

  const _InviteItem(
      {required this.title, required this.content, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      AppColors.color_list[0],
      elevation: 3,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(title, style: AppTS.normal),
            const SizedBox(height: 10),
            Text(content,
                style: AppTS.small.copyWith(color: AppColors.color_list[4])),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
