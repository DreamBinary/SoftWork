import 'package:account/app/component/mydialog.dart';
import 'package:account/app/component/myshimmer.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/data/net/api_guardian.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/toast.dart';
import 'package:account/res/assets_res.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../theme/app_colors.dart';

class GuardianPage extends StatelessWidget {
  const GuardianPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        middle: Text("监护人绑定", style: AppTS.normal),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsRes.GUARDIAN),
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GuardianItem(
              title: "我是监护人，我要...",
              btnTitle: "生成绑定码",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return MyDialog(
                      title: "我的绑定码",
                      height: 150.h,
                      child: SelectionArea(
                        child: FutureBuilder(
                          future: ApiGuardian.getCode(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              String code = snapshot.data ?? "6rhhc6zc";
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    code,
                                    style: AppTS.big32.copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 3),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        iconSize: 20,
                                        splashRadius: 20,
                                        icon: const Icon(Icons.copy),
                                        onPressed: () {
                                          FlutterClipboard.copy("邀请码: $code");
                                          ToastUtil.showToast("复制到剪切板");
                                        },
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        splashRadius: 20,
                                        iconSize: 20,
                                        icon: const Icon(Icons.share),
                                        onPressed: () {
                                          Share.share("邀请码: $code");
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            return ShimmerEffect(
                              child: Text(
                                "00000000",
                                style: AppTS.big32.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            _GuardianItem(
              title: "我是被监护人，我要...",
              btnTitle: '绑定监护人',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return MyDialog(
                      title: "输入绑定码",
                      height: 150.h,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: AppTS.big.copyWith(
                                fontWeight: FontWeight.bold, letterSpacing: 3),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _GuardianItem extends StatelessWidget {
  final String title;
  final String btnTitle;
  final VoidCallback? onPressed;

  const _GuardianItem(
      {required this.title, required this.btnTitle, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: AppTS.small),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(280, 45),
              shape: const StadiumBorder(),
              backgroundColor: AppColors.color_list[5]),
          child: Text(
            btnTitle,
            style: AppTS.big.copyWith(
              color: AppColors.textColor(AppColors.color_list[5]),
            ),
          ),
        ),
      ],
    );
  }
}
