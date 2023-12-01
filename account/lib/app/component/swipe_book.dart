import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/assets_res.dart';
import '../theme/app_colors.dart';

class SwiperBook extends StatefulWidget {
  final int num;
  final Function? onTapBook;
  final ValueChanged<int>? onIndexChanged;

  const SwiperBook(
      {required this.num,
      required this.onTapBook,
      required this.onIndexChanged,
      super.key});

  @override
  State<SwiperBook> createState() => _SwiperBookState();
}

class _SwiperBookState extends State<SwiperBook> {
  List<String> bookImgPath = [
    AssetsRes.BOOK0,
    AssetsRes.BOOK1,
    AssetsRes.BOOK2
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              itemCount: widget.num,
              viewportFraction: 0.6,
              scale: 0.7,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  color: Colors.white,
                  activeColor: AppColors.color_list[5],
                ),
              ),
              onIndexChanged: widget.onIndexChanged,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onTapBook?.call();
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(bookImgPath[index % 3]),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
