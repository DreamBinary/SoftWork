import 'package:account/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AudioItem extends StatefulWidget {
  final GestureLongPressCallback? onLongPress;
  final GestureLongPressEndCallback? onLongPressEnd;

  const AudioItem({this.onLongPress, this.onLongPressEnd, Key? key})
      : super(key: key);

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> with TickerProviderStateMixin {
  late final AnimationController _ctrlB0 = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1, milliseconds: 500),
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // print("completed0");
        _ctrlB0.reset();
        _ctrlB1.forward();
      }
    });


  late final AnimationController _ctrlB1 = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1, milliseconds: 500),
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // print("completed1");
        _ctrlB1.reset();
        _ctrlB0.forward();
      }
    });
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  double radius = 150;
  bool started = false;
  late final GestureLongPressCallback? onLongPress = widget.onLongPress;
  late final GestureLongPressEndCallback? onLongPressEnd = widget.onLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                  width: radius + _ctrlB0.value * radius,
                  height: radius + _ctrlB0.value * radius,
                  decoration: BoxDecoration(
                    color: AppColors.color_list[3].withOpacity(1 - _ctrlB0.value),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: radius + _ctrlB1.value * radius,
                  height: radius + _ctrlB1.value * radius,
                  decoration: BoxDecoration(
                    color: AppColors.color_list[4].withOpacity(1 - _ctrlB1.value),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onLongPress: () {
                    onLongPress!();
                    _ctrlB0.forward();
                    _ctrl.repeat(reverse: true);
                    started = true;
                  },
                  onLongPressEnd: (_) {
                    setState(() {
                      started = false;
                    });
                    onLongPressEnd!(_);
                    _ctrlB0.stop();
                    _ctrl.stop();
                    _ctrlB1.stop();
                  },
                  child: Container(
                      width: radius + _ctrl.value * 30,
                      height: radius + _ctrl.value * 30,
                      decoration: BoxDecoration(
                        color: AppColors.color_list[5],
                        shape: BoxShape.circle,
                      ),
                      child: started
                          ? Icon(
                              Icons.mic_rounded,
                              size: 50,
                              color: AppColors.color_list[0],
                            )
                          : Icon(Icons.mic_none_rounded,
                              size: 45, color: AppColors.color_list[0])),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
