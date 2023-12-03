import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/data/entity/consume.dart';
import 'package:account/app/routes/app_pages.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/toast.dart';
import 'package:account/res/assets_res.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../component/mydatepicker.dart';
import '../../component/myshowbottomsheet.dart';
import '../../component/picchoicebtn.dart';
import '../../component/select_chips.dart';
import '../../theme/app_string.dart';
import '../../utils/camera_util.dart';
import '../../utils/mmkv.dart';
import 'add_logic.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with SingleTickerProviderStateMixin {
  final logic = Get.find<AddLogic>();
  final state = Get.find<AddLogic>().state;
  late final TabController tabCtrl =
      TabController(initialIndex: 1, length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
    if (Get.arguments.runtimeType == ConsumeData) {
      logic.init(Get.arguments as ConsumeData);
    } else if (Get.arguments.runtimeType == List<String>) {
      logic.initWords(Get.arguments as List<String>);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: AppColors.color_list[5],
          ),
          onPressed: () async {
            bool result = await logic.upAdd();
            if (result) {
              ToastUtil.showToast("添加成功");
            } else {
              ToastUtil.showToast("添加失败");
            }
            Get.offAllNamed(Routes.route);
          },
          child: Text("完成",
              style: AppTS.small.copyWith(
                  color: AppColors.textColor(AppColors.color_list[5]))),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                flex: 3,
                child: TabBar(
                  controller: tabCtrl,
                  labelColor: Colors.black,
                  onTap: (index) => {tabCtrl.animateTo(index)},
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Text("收入", style: AppTS.normal),
                    Text("支出", style: AppTS.normal),
                  ],
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabCtrl,
              children: const [
                IncomePage(),
                ExpendPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IncomePage extends StatelessWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addItems = <Map<String, dynamic>>[
      {"label": "名称", "ctrl": TextEditingController()},
      {"label": "日期", "ctrl": TextEditingController()},
      {"label": "备注", "ctrl": TextEditingController()},
    ];
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 40.w, right: 40.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InputTextField(
              ctrl: TextEditingController(),
              isSuffix: true,
              isNum: true,
              verticalPadding: 10.h,
            ),
            SizedBox(height: 15.h),
            ...List.generate(
              addItems.length,
              (index) => AddItem(
                addItems[index]["label"],
                InputTextField(
                  ctrl: addItems[index]["ctrl"],
                ),
              ),
            ),
            const AddItem("分类", _ClassSelect()),
          ],
        ),
      ),
    );
  }
}

class ExpendPage extends StatefulWidget {
  const ExpendPage({Key? key}) : super(key: key);

  @override
  State<ExpendPage> createState() => _ExpendPageState();
}

class _ExpendPageState extends State<ExpendPage> {
  final logic = Get.find<AddLogic>();

  final state = Get.find<AddLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 40.w, right: 40.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InputTextField(
              ctrl: state.moneyCtrl,
              chips: state.wordList.isNotEmpty ? state.wordList : null,
              isSuffix: true,
              isNum: true,
              verticalPadding: 10.h,
              style: AppTS.normal,
            ),
            SizedBox(height: 15.h),
            AddItem(
              "物品",
              InputTextField(
                ctrl: state.nameCtrl,
                chips: state.wordList.isNotEmpty ? state.wordList : null,
              ),
            ),
            AddItem(
              "日期",
              GestureDetector(
                onTap: () async {
                  myShowBottomSheet(
                    context: context,
                    builder: (context) {
                      return MyDatePicker(
                        isSingleDay: true,
                        changeTime: (start_, end_, isMonth_) {
                          setState(() {
                            state.dateCtrl.text = start_;
                          });
                        },
                      );
                    },
                  );
                },
                child: InputTextField(
                  enabled: false,
                  ctrl: state.dateCtrl,
                ),
              ),
            ),
            AddItem(
              "商家",
              InputTextField(
                ctrl: state.merchantCtrl,
                chips: state.wordList.isNotEmpty ? state.wordList : null,
              ),
            ),
            AddItem(
              "备注",
              InputTextField(
                ctrl: state.remarkCtrl,
                chips: state.wordList.isNotEmpty ? state.wordList : null,
              ),
            ),
            AddItem("分类", _ClassSelect(initvalue: state.typeId)),
            // GestureDetector(
            //   onTap: () {
            //     myShowBottomSheet(
            //       context: context,
            //       builder: (context) => Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           SizedBox(height: 20.h),
            //           PicChoiceBtn(
            //             title: "拍照",
            //             onPressed: () async {
            //               XFile? image = await CameraUtil.getCamera();
            //               if (image == null) {
            //                 return;
            //               }
            //               List<String> urls = await CameraUtil.upImg(image);
            //               setState(() {
            //                 state.imgUrl = urls[0];
            //               });
            //             },
            //           ),
            //           SizedBox(height: 10.h),
            //           PicChoiceBtn(
            //             title: "相册",
            //             onPressed: () async {
            //               XFile? image = await CameraUtil.getGallery();
            //               if (image == null) {
            //                 return;
            //               }
            //               List<String> urls = await CameraUtil.upImg(image);
            //               setState(() {
            //                 state.imgUrl = urls[0];
            //               });
            //             },
            //           ),
            //           SizedBox(height: 20.h),
            //         ],
            //       ),
            //     );
            //   },
            //   child: DottedBorder(
            //     borderType: BorderType.RRect,
            //     radius: Radius.circular(30.r),
            //     child: Container(
            //         width: 270.w,
            //         height: 350.h,
            //         margin: const EdgeInsets.all(5),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(40.r),
            //           image: state.imgUrl == null
            //               ? null
            //               : DecorationImage(
            //                   image: NetworkImage(
            //                     state.imgUrl!,
            //                     headers: {
            //                       "token": MMKVUtil.getString(AppString.mmToken)
            //                     },
            //                   ),
            //                   fit: BoxFit.contain,
            //                 ),
            //         ),
            //         child: state.imgUrl == null
            //             ? Center(
            //                 child: Text(
            //                   "点击添加图片",
            //                   style: AppTS.normal,
            //                 ),
            //               )
            //             : null),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _ClassSelect extends StatefulWidget {
  final int initvalue;

  const _ClassSelect({this.initvalue = 0, Key? key}) : super(key: key);

  @override
  State<_ClassSelect> createState() => _ClassSelectState();
}

class _ClassSelectState extends State<_ClassSelect> {
  final classInfo = [
    {"path": AssetsRes.CLASS_TRANSPORT, "label": "交通"},
    {"path": AssetsRes.CLASS_OFFICE, "label": "办公"}, //
    {"path": AssetsRes.CLASS_DAILY, "label": "日用"}, //
    {"path": AssetsRes.CLASS_SERVICE, "label": "服务"}, //
    {"path": AssetsRes.CLASS_DIGITAL, "label": "数码"}, //
    {"path": AssetsRes.CLASS_DECORATION, "label": "房租"}, //
    {"path": AssetsRes.CLASS_COMMUNICATION, "label": "通讯"},
    {"path": AssetsRes.CLASS_ACCOMMODATION, "label": "住宿"}, //
    {"path": AssetsRes.CLASS_MAIL, "label": "邮寄"}, //
    {"path": AssetsRes.CLASS_MEDICINE, "label": "医疗"},
    {"path": AssetsRes.CLASS_CATERING, "label": "餐饮"}, //
    {"path": AssetsRes.CLASS_FOOD, "label": "食品"}, //
    {"path": AssetsRes.CLASS_DECORATION, "label": "服饰"}, //
    {"path": AssetsRes.CLASS_USECAR, "label": "用车"}, //
    {"path": AssetsRes.CLASS_EDUCATE, "label": "教育"},
    {"path": AssetsRes.CLASS_OTHER, "label": "其他"},
  ];
  final subClassInfo = {
    "交通": ["公交地铁", "打车", "飞机", "火车/动车", "轮船", "长途汽车", "其他"],
    "办公": ["旅费", "其他"],
    "日用": ["请客", "其他"],
    "服务": ["药品", "医疗", "其他"],
    "数码": ["手机", "电脑", "电视", "相机", "其他"],
    "房租": ["房租", "水电费", "物业费", "装修", "其他"],
    "通讯": ["话费", "流量", "其他"],
    "住宿": ["其他"],
    "邮寄": ["其他"],
    "医疗": ["其他"],
    "餐饮": ["火锅", "海底捞", "其他"],
    "食品": ["其他"],
    "服饰": ["其他"],
    "用车": ["其他"],
    "教育": ["书籍", "学习用品", "其他"],
    "其他": ["其他"],
  };
  late var value0 = widget.initvalue;
  var value1 = 0;
  late var label = classInfo[value0]["label"];
  late var subLabel = subClassInfo[classInfo[value0]["label"]]![value1];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClassItem(
          value: value0,
          items: List.generate(
            classInfo.length,
            (index) => DropdownMenuItem(
              value: index,
              onTap: () {
                setState(
                  () {
                    value0 = index;
                    label = classInfo[value0]["label"]!;
                    value1 = 0;
                    subLabel = subClassInfo[label]![value1];
                  },
                );
              },
              child: ClassSubItem(
                path: classInfo[index]["path"]!,
                label: classInfo[index]["label"]!,
                isSelect: value0 == index,
              ),
            ),
          ),
        ),
        StatefulBuilder(
          builder: (context, aSetState) => ClassItem(
            value: value1,
            items: List.generate(
              subClassInfo[label]!.length,
              (index) => DropdownMenuItem(
                value: index,
                onTap: () {
                  aSetState(() {
                    value1 = index;
                    subLabel = subClassInfo[label]![index];
                  });
                },
                child: ClassSubItem(
                  label: subClassInfo[label]![index],
                  isSelect: value1 == index,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ClassItem<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;

  const ClassItem({this.items, this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: DropdownButton(
        value: value,
        iconSize: 0,
        borderRadius: BorderRadius.circular(15),
        underline: const SizedBox(),
        alignment: Alignment.center,
        dropdownColor: AppColors.color_list[3],
        items: items,
        onChanged: (value) {},
      ),
    );
  }
}

class ClassSubItem extends StatelessWidget {
  final String? path;
  final String label;
  final bool isSelect;

  const ClassSubItem(
      {this.path, required this.label, required this.isSelect, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: isSelect
          ? BoxDecoration(
              color: AppColors.color_list[1],
              borderRadius: BorderRadius.circular(15),
            )
          : null,
      child: Center(
        child: path == null
            ? Text(
                label,
                style: AppTS.small,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(path!, width: 25.w, height: 25.h),
                  const SizedBox(width: 5),
                  Text(
                    label,
                    style: AppTS.small,
                  )
                ],
              ),
      ),
    );
  }
}

class AddItem extends StatelessWidget {
  const AddItem(this.title, this.child, {Key? key}) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Text(title, style: AppTS.small)),
          Expanded(flex: 7, child: child)
        ],
      ),
    );
  }
}

class InputTextField extends StatefulWidget {
  final TextEditingController ctrl;
  final bool isSuffix;
  final bool isNum;
  final double verticalPadding;
  final TextStyle? style;
  final List<String>? chips;
  final bool enabled;

  InputTextField(
      {super.key,
      required this.ctrl,
      this.isSuffix = false,
      this.isNum = false,
      this.style,
      this.enabled = true,
      this.chips,
      this.verticalPadding = 5});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final FocusNode focusNode = FocusNode();
  List<String>? chips;
  String text = "";

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          chips = widget.chips;
        });
      } else {
        setState(() {
          chips = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: focusNode,
          enabled: widget.enabled,
          controller: widget.ctrl,
          style: widget.style ?? AppTS.small,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(
                maxHeight: 30.h,
                maxWidth: 30.w,
              ),
              suffixIcon: widget.isSuffix
                  ? Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Text("元", style: AppTS.small))
                  : null,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w, vertical: widget.verticalPadding),
              fillColor: AppColors.color_list[3].withAlpha(153),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              filled: true,
              isCollapsed: true,
              isDense: true),
          textInputAction: TextInputAction.next,
          keyboardType: widget.isNum ? TextInputType.number : null,
          onChanged: chips == null
              ? null
              : (t) {
                  if (t.length != text.length) {
                    setState(() {
                      chips = null;
                    });
                  }
                },
        ),
        if (chips != null)
          SelectChips(
            items: chips!,
            onChanged: (result) {
              text = "";
              for (int i in result) {
                text += chips![i];
              }
              widget.ctrl.text = text;
            },
          )
      ],
    );
  }
}
