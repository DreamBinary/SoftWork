import 'dart:math';
import 'package:account/app/component/refresh_indicator.dart';
import 'package:account/app/routes/app_pages.dart';
import 'package:account/app/utils/floating_util.dart';
import 'package:account/app/component/lines_text.dart';
import 'package:account/app/component/mybottombar.dart';
import 'package:account/app/component/mycard.dart';
import 'package:account/app/component/mydatepicker.dart';
import 'package:account/app/component/myshowbottomsheet.dart';
import 'package:account/app/modules/home/home_logic.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/utils/camera_util.dart';
import 'package:account/app/utils/date_util.dart';
import 'package:account/app/utils/extension.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import '../../component/myiconbtn.dart';
import '../../component/myshimmer.dart';
import '../../component/picchoicebtn.dart';
import '../../component/sound_page.dart';
import '../../component/version_ctrl.dart';
import '../../data/entity/consume.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (VersionCtrl.of(context)?.version != 0) {
      return const _SHomePage();
    }
    return const MHomePage();
  }
}

class MHomePage extends StatefulWidget {
  const MHomePage({Key? key}) : super(key: key);

  @override
  State<MHomePage> createState() => _MHomePageState();
}

class _MHomePageState extends State<MHomePage> {
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  late String start = state.start ?? DateUtil.getNowFormattedDate();
  late String end = state.end ?? DateUtil.getNowFormattedDate();
  late String showTime =
      isMonth ? start : (start == end ? start : "$start -> $end");
  late bool isMonth = state.isMonth;

  List<String> bookImgPath = [
    AssetsRes.BOOK0,
    AssetsRes.BOOK1,
    AssetsRes.BOOK2
  ];
  List<String> bookName = ["我的日常", "家人们", "舍友们"];

  var _currentBook = 0;

  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();

  @override
  void initState() {
    super.initState();
    screenListener.addScreenShotListener(
      (filePath) async {
        FloatingUtil.end();
        await Future.delayed(const Duration(milliseconds: 100));
        // TODO
        // var urls = await ApiImg.upImg(imgPaths: [filePath]);
        // Get.to(CroppingPage(
        //     fileName: urls[0].split('/').last, isScreenShot: true));
        screenListener.dispose();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: CustomRefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        builder: MaterialIndicatorDelegate(
          backgroundColor: AppColors.whiteBg,
          builder: (context, controller) {
            return const MyRefreshIndicator();
          },
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.color_list[1],
              automaticallyImplyLeading: false,
              expandedHeight: 250.h,
              pinned: true,
              centerTitle: true,
              title: Text(bookName[_currentBook], style: AppTS.big),
              leading: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: MyIconBtn(
                  onPressed: () async {
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(0, 100, 0, 0),
                      items: List.generate(
                        bookImgPath.length,
                        (index) => PopupMenuItem(
                          value: index,
                          onTap: () {
                            setState(() {
                              _currentBook = index;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              CircleAvatar(
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage(bookImgPath[index])),
                              const SizedBox(width: 15),
                              Text(bookName[index], style: AppTS.small)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  color: AppColors.color_list[5],
                  imgPath: AssetsRes.CHANGE_BOOK,
                ),
              ),
              leadingWidth: 65.w,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: MyIconBtn(
                    onPressed: () async {},
                    color: AppColors.color_list[5],
                    imgPath: AssetsRes.SEARCH,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Align(
                  alignment: Alignment.bottomLeft,
                  child: FutureBuilder(
                    future: Future.delayed(const Duration(milliseconds: 500)),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _HomeTopPart(
                          time: showTime,
                          allExpense: snapshot.data![0],
                          allIncome: snapshot.data![1],
                          filterTap: () {
                            myShowBottomSheet(
                              context: context,
                              builder: (context) {
                                return MyDatePicker(
                                  changeTime: (start_, end_, isMonth_) {
                                    setState(
                                      () {
                                        start = start_;
                                        end = end_;
                                        isMonth = isMonth_;
                                        showTime = isMonth
                                            ? start
                                            : (start == end
                                                ? start
                                                : "$start -> $end");
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return ShimmerEffect(
                          child: _HomeTopPart(
                            time: "0000-00-00",
                            allExpense: 0.00,
                            allIncome: 0.00,
                            filterTap: () {},
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 500)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Map<String, List<ConsumeData>>> data =
                      snapshot.data as List<Map<String, List<ConsumeData>>>;
                  int len = data.length;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0) {
                          return const _CardMarker();
                        } else if (index == len + 1) {
                          return MyBottomBarPlaceholder(
                            color: AppColors.whiteBg,
                            addHeight: 65.h,
                          );
                        } else {
                          return DayRecord(
                            colorBg: AppColors.whiteBg,
                            data: data[index - 1],
                          );
                        }
                      },
                      childCount: len + 2,
                    ),
                  );
                } else {
                  return SliverFillRemaining(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _CardMarker(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            2,
                            (index) => const _ShimmerItem(),
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: AppColors.whiteBg,
              ),
            )
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: CircularMenu(
        toggleButtonColor: AppColors.color_list[5],
        toggleButtonAnimatedIconData: AnimatedIcons.menu_close,
        toggleButtonSize: 30,
        alignment: Alignment.bottomRight,
        items: [
          MyCircularMenuItem(
            icon: Icons.mic_none_rounded,
            color: AppColors.color_list[4],
            onTap: () async {
              Get.to(() => const SoundPage());
            },
          ),
          MyCircularMenuItem(
            icon: Icons.camera_alt_outlined,
            color: AppColors.color_list[3],
            onTap: () async {
              _getCameraChoice();
            },
          ),
          MyCircularMenuItem(
            icon: Icons.edit_outlined,
            color: AppColors.color_list[2],
            onTap: () async {
              Get.toNamed(Routes.add);
            },
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomBarPlaceholder(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    screenListener.dispose();
  }

  // void ocr(String url) {
  //   String token = MMKVUtil.getString(AppString.mmToken);
  //   Get.to(CropImg(
  //     image: Image.network(
  //       url,
  //       headers: {"token": token},
  //     ),
  //     onCropped: (Image image, String path) async {
  //       List<String> urls = await ApiImg.upImg(imgPaths: [path]);
  //     },
  //   ));
  // }

  // void _getCropping({XFile? image, String? path}) async {
  //   if (image == null && path == null || image != null && path != null) {
  //     return;
  //   }
  //   late List<String> urls;
  //   if (image != null) {
  //     urls = await CameraUtil.upImg(image);
  //   } else if (path != null) {
  //     urls = await ApiImg.upImg(imgPaths: [path]);
  //   }
  //
  //   Get.to(CroppingPage(fileName: urls[0].split('/').last));
  // }

  void _getCameraChoice() {
    myShowBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          PicChoiceBtn(
            title: "截屏",
            onPressed: () async {
              screenListener.watch();
              await FloatingUtil.start();
            },
          ),
          SizedBox(height: 10.h),
          PicChoiceBtn(
            title: "拍照",
            onPressed: () async {
              XFile? image = await CameraUtil.getCamera();
              if (image == null) {
                return;
              }
              List<String> urls = await CameraUtil.upImg(image);
              // TODO
              // Get.to(CroppingPage(fileName: urls[0].split('/').last));
            },
          ),
          SizedBox(height: 10.h),
          PicChoiceBtn(
            title: "相册",
            onPressed: () async {
              XFile? image = await CameraUtil.getGallery();
              if (image == null) {
                return;
              }
              List<String> urls = await CameraUtil.upImg(image);
              // TODO
              // Get.to(CroppingPage(fileName: urls[0].split('/').last));
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class MyCircularMenuItem extends CircularMenuItem {
  MyCircularMenuItem(
      {required super.icon,
      required super.color,
      required super.onTap,
      super.margin = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: super.build(context),
    );
  }
}

class _SHomePage extends StatefulWidget {
  const _SHomePage({Key? key}) : super(key: key);

  @override
  State<_SHomePage> createState() => _SHomePageState();
}

class _SHomePageState extends State<_SHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _CardMarker extends StatelessWidget {
  const _CardMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.color_list[1],
      child: Container(
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.whiteBg,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 10,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.color_list[1],
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTopPart extends StatelessWidget {
  final String time;
  final double allExpense;
  final double allIncome;
  final VoidCallback filterTap;
  final bool isOld;

  const _HomeTopPart({
    required this.time,
    required this.allIncome,
    required this.allExpense,
    required this.filterTap,
    this.isOld = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RawMaterialButton(
              onPressed: filterTap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetsRes.FILTER,
                    height: 30,
                    width: 30,
                    color: AppColors.color_list.last,
                  ),
                  Text(
                    time,
                    style: isOld ? AppTS.big : AppTS.normal,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Text("结余", style: isOld ? AppTS.big32 : AppTS.normal),
            const SizedBox(height: 5),
            Text(
              (max(allIncome - allExpense, 0.0)).moneyFormatZero,
              style: isOld ? AppTS.large48 : AppTS.large,
            ),
            const SizedBox(height: 5),
            if (!isOld)
              Text(
                "总支出 ${allExpense.moneyFormatZero}  总收入 ${allIncome.moneyFormatZero}",
                style: isOld ? AppTS.big : AppTS.normal,
              ),
          ],
        ),
      ),
    );
  }
}

class DayRecord extends StatefulWidget {
  final Color colorBg;
  final Map<String, List<ConsumeData>> data;
  final bool isOld;

  const DayRecord(
      {Key? key, required this.colorBg, required this.data, this.isOld = false})
      : super(key: key);

  @override
  State<DayRecord> createState() => _DayRecordState();
}

class _DayRecordState extends State<DayRecord> {
  @override
  Widget build(BuildContext context) {
    var time = widget.data.keys.first;
    var typeId = List.generate(widget.data.values.first.length,
        (i) => widget.data.values.first[i].typeId);
    var titles = List.generate(
      widget.data.values.first.length,
      (i) => widget.data.values.first[i].consumptionName,
    );
    var subTitles = List.generate(
      widget.data.values.first.length,
      (i) => widget.data.values.first[i].store,
    );
    var contents = List.generate(
      widget.data.values.first.length,
      (i) => widget.data.values.first[i].amount.moneyFormatZero,
    );
    var colors = AppColors.randomColor(num: titles.length);
    return Container(
      color: widget.colorBg,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: widget.isOld
                ? BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside),
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(
                  time,
                  style: AppTS.small
                      .copyWith(color: AppColors.textColor(colors[0])),
                ),
                backgroundColor: colors[0]),
          ),
          ...List.generate(
            titles.length,
            (index) {
              Color textColor = AppColors.textColor(colors[index]);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Container(
                  decoration: widget.isOld
                      ? BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          borderRadius: BorderRadius.circular(20),
                        )
                      : null,
                  child: MyCard(
                    colors[index],
                    height: 80.h,
                    elevation: 8,
                    onPressed: () {
                      Get.toNamed(
                        Routes.add,
                        arguments: widget.data.values.first[index],
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 15.w),
                        if (!widget.isOld) ...[
                          CircleAvatar(
                            backgroundColor: AppColors.whiteBg,
                            child: Image.asset(
                              ConsumeData.paths[typeId[index]],
                              height: 25,
                              width: 25,
                            ),
                          ),
                          SizedBox(width: 15.w),
                        ],
                        Expanded(
                          child: LinesTextItem(
                            texts: widget.isOld
                                ? [titles[index]]
                                : [titles[index], subTitles[index]],
                            styles: widget.isOld
                                ? [
                                    AppTS.normal.copyWith(color: textColor),
                                  ]
                                : [
                                    AppTS.normal.copyWith(color: textColor),
                                    AppTS.small.copyWith(color: textColor)
                                  ],
                            textAlign: CrossAxisAlignment.start,
                            textColor: textColor,
                          ),
                        ),
                        Text(contents[index],
                            style: AppTS.normal.copyWith(color: textColor)),
                        SizedBox(width: 15.w),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SOnePage extends StatefulWidget {
  const _SOnePage({Key? key}) : super(key: key);

  @override
  State<_SOnePage> createState() => _SOnePageState();
}

class _SOnePageState extends State<_SOnePage> {
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  late String start = state.start ?? DateUtil.getNowFormattedDate();
  late String end = state.end ?? DateUtil.getNowFormattedDate();
  late String showTime =
      isMonth ? start : (start == end ? start : "$start -> $end");
  late bool isMonth = state.isMonth;

  List<String> bookImgPath = [
    AssetsRes.BOOK0,
    AssetsRes.BOOK1,
    AssetsRes.BOOK2
  ];
  List<String> bookName = ["我的日常", "家人们", "舍友们"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 10.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.color_list[0],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 500)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _HomeTopPart(
                      time: showTime,
                      allExpense: snapshot.data![0],
                      allIncome: snapshot.data![1],
                      isOld: true,
                      filterTap: () {
                        myShowBottomSheet(
                          context: context,
                          builder: (context) {
                            return MyDatePicker(
                              changeTime: (start_, end_, isMonth_) {
                                setState(
                                  () {
                                    start = start_;
                                    end = end_;
                                    isMonth = isMonth_;
                                    showTime = isMonth
                                        ? start
                                        : (start == end
                                            ? start
                                            : "$start -> $end");
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return ShimmerEffect(
                      child: _HomeTopPart(
                        time: "0000-00-00",
                        allExpense: 0.00,
                        allIncome: 0.00,
                        isOld: true,
                        filterTap: () {},
                      ),
                    );
                  }
                },
              ),
            ),
            FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 500)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Map<String, List<ConsumeData>>> data =
                      snapshot.data as List<Map<String, List<ConsumeData>>>;
                  int len = data.length;
                  return Column(
                    children: List.generate(
                      len + 1,
                      (index) {
                        if (index == len) {
                          return MyBottomBarPlaceholder(
                            color: Colors.transparent,
                            addHeight: -5.h,
                          );
                        } else {
                          return DayRecord(
                            data: data[index],
                            colorBg: Colors.transparent,
                            isOld: true,
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        _ShimmerItem(),
                        _ShimmerItem(),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String title;
  final Color indicateColor;
  final bool isSelect;
  final GestureTapCallback? onTap;

  const _Tab({
    required this.title,
    required this.indicateColor,
    required this.isSelect,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = isSelect ? indicateColor : AppColors.whiteBg;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        color: Colors.transparent,
        child: Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(title,
                    style:
                        AppTS.big.copyWith(color: AppColors.textColor(color))),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteBg,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerEffect(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Chip(
                label: Text(
                  "2023-01-01",
                  style: AppTS.small,
                ),
              ),
            ),
          ),
          ShimmerEffect(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: MyCard(
                Colors.white,
                height: 80.h,
                elevation: 0,
              ),
            ),
          ),
          ShimmerEffect(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: MyCard(
                Colors.white,
                height: 80.h,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
