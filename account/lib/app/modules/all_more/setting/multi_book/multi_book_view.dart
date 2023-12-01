import 'package:account/app/component/loading_page.dart';
import 'package:account/app/component/mycard.dart';
import 'package:account/app/component/mydialog.dart';
import 'package:account/app/component/myshowbottomsheet.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/data/entity/multi_book.dart';
import 'package:account/app/data/net/api_multi.dart';
import 'package:account/app/modules/all_more/setting/multi_book/member.dart';
import 'package:account/app/modules/all_more/setting/multi_book/multi_book_logic.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/toast.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/myelevatedbtn.dart';
import '../../../../component/myiconbtn.dart';
import '../../../../component/swipe_book.dart';
import '../../../../component/version_ctrl.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_string.dart';
import '../../../../utils/mmkv.dart';

class MultiBookPage extends StatefulWidget {
  const MultiBookPage({Key? key}) : super(key: key);

  @override
  State<MultiBookPage> createState() => _MultiBookPageState();
}

class _MultiBookPageState extends State<MultiBookPage> {
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
        trailing: MyIconBtn(
          onPressed: () async {},
          imgPath: AssetsRes.BUDGET_TOP_ICON,
          color: AppColors.color_list[5],
        ),
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
  final logic = Get.find<MultiBookLogic>();
  final state = Get.find<MultiBookLogic>().state;

  late List<MultiBook> data;
  var currentIndex = 0;
  late StateSetter mState;

  @override
  void initState() {
    super.initState();
    data = Get.arguments as List<MultiBook>;
    if (MMKVUtil.getBool(AppString.mmOpenLock)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _showLock(context);
      });
    }
  }

  addBook() async {
    await myShowBottomSheet(
      context: context,
      builder: (context) {
        return AddBook(
          hasDescription: true,
          onCancel: () {
            Get.back();
          },
          onConfirm: (name, description) async {
            var result = await ApiMultiBook.addMultiBook(name, description);
            if (result) {
              ToastUtil.showToast("添加成功");
              data = await ApiMultiBook.getMultiBook();
              setState(() {});
            } else {
              ToastUtil.showToast("添加失败");
            }
            Get.back();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: Text("多人账本", style: AppTS.normal),
        trailing: MyIconBtn(
          onPressed: addBook,
          imgPath: AssetsRes.BUDGET_TOP_ICON,
          color: AppColors.color_list[3],
        ),
      ),
      body: data.isEmpty
          ? Center(child: Text("暂无账本", style: AppTS.large))
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwiperBook(
                  num: data.length,
                  onTapBook: () {
                    Get.to(
                      LoadingPage(
                        future: ApiMultiBook.getMultiBookUser(
                          data[currentIndex].multiLedgerId,
                        ),
                      ),
                    )?.then(
                      (value) => Get.to(
                        () => MemberPage(
                          multiLedgerId: data[currentIndex].multiLedgerId,
                        ),
                        arguments: value,
                      ),
                    );
                  },
                  onIndexChanged: (index) {
                    currentIndex = index;
                    mState(() {});
                  },
                ),
                StatefulBuilder(
                  builder: (_, aState) {
                    mState = aState;
                    return _DetailPart(
                      bookName: data[currentIndex].multiLedgerName,
                      description: data[currentIndex].description,
                      time: data[currentIndex].modifyTime,
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class _DetailPart extends StatelessWidget {
  final String time;
  final String bookName;
  final String description;

  const _DetailPart({
    required this.bookName,
    required this.description,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Text(bookName, style: AppTS.big),
          SizedBox(height: 10.h),
          Text("修改于 $time", style: AppTS.small),
          SizedBox(height: 30.h),
          Text(
            description + description,
            style: AppTS.normal.copyWith(
              letterSpacing: 1,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 6,
          ),
        ],
      ),
    );
  }
}

class AddBook extends StatefulWidget {
  final bool hasDescription;
  final VoidCallback? onCancel;
  final Function(String, String)? onConfirm;

  const AddBook({
    required this.onCancel,
    required this.onConfirm,
    this.hasDescription = false,
    super.key,
  });

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _nameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "添加账本",
          textAlign: TextAlign.center,
          style: AppTS.normal,
        ).paddingSymmetric(vertical: 20.h),
        TextField(
          controller: _nameCtrl,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: "账本名称",
          ),
        ).paddingSymmetric(horizontal: 20.w),
        if (widget.hasDescription) SizedBox(height: 20.h),
        if (widget.hasDescription)
          TextField(
            controller: _descriptionCtrl,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "账本描述",
            ),
          ).paddingSymmetric(horizontal: 20.w),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyElevatedBtn(
              color: AppColors.color_list.first,
              onPressed: () {
                widget.onCancel?.call();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "取消",
                  style: AppTS.small.copyWith(
                    color: AppColors.textColor(AppColors.color_list.first),
                  ),
                ),
              ),
            ),
            MyElevatedBtn(
              color: AppColors.color_list.last,
              onPressed: () {
                widget.onConfirm?.call(
                  _nameCtrl.text,
                  _descriptionCtrl.text,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "确定",
                  style: AppTS.small.copyWith(
                    color: AppColors.textColor(AppColors.color_list.last),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
