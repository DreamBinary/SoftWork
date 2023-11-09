import 'package:account/app/component/mycard.dart';
import 'package:account/app/component/mydialog.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/toast.dart';
import 'package:account/res/assets_res.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/multi_column_row.dart';
import '../../../component/version_ctrl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_string.dart';
import '../../../utils/mmkv.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({Key? key}) : super(key: key);

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  @override
  Widget build(BuildContext context) {
    if (VersionCtrl.of(context)?.version != 0) {
      return const _SMyBookPage();
    }
    return const _MMyBookPage();
  }
}

class _SMyBookPage extends StatefulWidget {
  const _SMyBookPage({Key? key}) : super(key: key);

  @override
  State<_SMyBookPage> createState() => _SMyBookPageState();
}

class _SMyBookPageState extends State<_SMyBookPage> {
  List<String> bookImgPath = [
    AssetsRes.BOOK0,
    AssetsRes.BOOK1,
    AssetsRes.BOOK2
  ];
  List<String> bookName = ["我的日常", "家人们", "舍友们"];

  late List<Color> colors = AppColors.randomColor(num: bookName.length);

  List<List<String>> values = [
    ["2000", "2540", "0"],
    ["5000", "3060", "1940"],
    ["200", "200", "0"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: Text("我的账本", style: AppTS.normal),
      ),
      body: Column(
        children: List.generate(
          bookName.length,
          (index) => _SBook(
            color: colors[index],
            bookName: bookName[index],
            bookImgPath: bookImgPath[index],
            income: values[index][0],
            expense: values[index][1],
            balance: values[index][2],
          ),
        ),
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}

Future<void> _showLock(BuildContext context) async {
  List<String> locks = [
    AssetsRes.LOCK0,
    AssetsRes.LOCK1,
    AssetsRes.LOCK2,
    AssetsRes.LOCK3,
    AssetsRes.LOCK4,
    AssetsRes.LOCK5,
    AssetsRes.LOCK6,
  ];
  bool? result = await showDialog(
    context: context,
    builder: (context) {
      return MyDialog(
        title: "",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(locks[AppColors.currentIndex]),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text("账本上锁啦", style: AppTS.small),
            Text("请输入密码", style: AppTS.small),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                elevation: 10,
                shape: const StadiumBorder(),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: AppTS.big
                      .copyWith(fontWeight: FontWeight.bold, letterSpacing: 3),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                  onSubmitted: (str) {
                    if (str == "123456") {
                      Get.back(result: true);
                    } else {
                      ToastUtil.showToast("密码错误");
                      Get.back(result: false);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      );
    },
  );
  if (result == null || !result) {
    Get.back();
  }
}

class _SBook extends StatelessWidget {
  final Color color;
  final String bookName;
  final String bookImgPath;
  final String income;
  final String expense;
  final String balance;

  const _SBook(
      {required this.color,
      required this.bookName,
      required this.bookImgPath,
      this.income = "0",
      this.expense = "0",
      this.balance = "0",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      color,
      height: 200.h,
      child: Row(
        children: [
          Container(
            width: 125.w,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(bookImgPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                bookName,
                style: AppTS.big.copyWith(color: AppColors.textColor(color)),
              ),
              Text(
                "总收入: $income",
                style: AppTS.normal.copyWith(color: AppColors.textColor(color)),
              ),
              Text(
                "总支出: $expense",
                style: AppTS.normal.copyWith(color: AppColors.textColor(color)),
              ),
              Text(
                "总余额: $balance",
                style: AppTS.normal.copyWith(color: AppColors.textColor(color)),
              ),
            ],
          )
        ],
      ).paddingAll(10),
    ).paddingAll(5);
  }
}

class _MMyBookPage extends StatefulWidget {
  const _MMyBookPage();

  @override
  State<_MMyBookPage> createState() => _MMyBookPageState();
}

class _MMyBookPageState extends State<_MMyBookPage> {
  @override
  Widget build(BuildContext context) {
    List<String> bookImgPath = [
      AssetsRes.BOOK0,
      AssetsRes.BOOK1,
      AssetsRes.BOOK2
    ];
    List<String> bookName = ["我的日常", "家人们", "舍友们"];

    List<List<String>> values = [
      ["2000", "2540", "0"],
      ["5000", "3060", "1940"],
      ["200", "200", "0"],
    ];

    List<DateTime> dates = [
      DateTime(2023, 11, 1),
      DateTime(2023, 11, 3),
      DateTime(2023, 11, 10),
    ];

    var currentIndex = 0;
    late StateSetter mState;

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: Text("我的账本", style: AppTS.normal),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 400.h,
            margin: EdgeInsets.only(top: 20.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.whiteBg,
                  AppColors.whiteBg,
                  AppColors.color_list[2],
                  AppColors.color_list[2],
                  AppColors.whiteBg,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 330.h,
                  child: Swiper(
                    itemCount: bookImgPath.length,
                    viewportFraction: 0.6,
                    scale: 0.7,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: AppColors.color_list[5],
                      ),
                    ),
                    onIndexChanged: (index) {
                      mState(() {
                        currentIndex = index;
                        print(bookName[currentIndex]);
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(bookImgPath[index]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          StatefulBuilder(
            builder: (_, aState) {
              mState = aState;
              return _DetailPart(
                bookName: bookName[currentIndex],
                values: values[currentIndex],
                time: dates[currentIndex],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (MMKVUtil.getBool(AppString.mmOpenLock)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _showLock(context);
      });
    }
  }
}

class _DetailPart extends StatelessWidget {
  final DateTime time;
  final String bookName;
  final List<String>? values;

  const _DetailPart(
      {required this.bookName,
      required this.values,
      required this.time,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(bookName, style: AppTS.big),
        SizedBox(height: 10.h),
        Text("${time.year}年${time.month}月${time.day}日创建", style: AppTS.small),
        SizedBox(height: 30.h),
        MultiColumnRow(
          titles: const [
            "总收入",
            "总支出",
            "总余额",
          ],
          subTitles: values,
          decTextStyle: AppTS.big,
          hasDivider: true,
          crossAxisAlignment: CrossAxisAlignment.center,
        ).paddingSymmetric(horizontal: 30.w),
      ],
    );
  }
}
