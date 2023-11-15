import 'package:flutter/material.dart';

const double kMargin = 14.0;
const double kHeight = 80.0;
const double kCircleRadius = 30.0;
const double kCircleMargin = 8.0;
const double kTopRadius = 8;
const double kTopMargin = 12.0;
const double kIconSize = 24.0;
const double kPi = 3.1415926535897932;

class MyBottomBarPlaceholder extends StatelessWidget {
  final Color color;
  final double addHeight;

  const MyBottomBarPlaceholder(
      {this.color = Colors.transparent, this.addHeight = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: double.maxFinite,
      height: kHeight - kTopMargin + addHeight,
    );
  }
}

class MyBottomBar extends StatefulWidget {
  final PageController pageController;
  final List<BottomBarItem> bottomBarItems;
  final ValueChanged<int> onTap;
  final Color color;
  final bool showShadow;
  final bool showLabel;
  final TextStyle? itemLabelStyle;
  final Color notchColor;

  const MyBottomBar(
      {Key? key,
      required this.pageController,
      required this.bottomBarItems,
      required this.onTap,
      this.color = Colors.white,
      this.itemLabelStyle,
      this.showShadow = true,
      this.showLabel = true,
      this.notchColor = Colors.white})
      : super(key: key);

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  late double _screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    const height = kHeight;
    return AnimatedBuilder(
      animation: widget.pageController,
      builder: (BuildContext _, Widget? child) {
        double scrollPosition = widget.pageController.initialPage.toDouble();
        int currentIndex = widget.pageController.initialPage;
        if (widget.pageController.hasClients) {
          scrollPosition = widget.pageController.page!;
          currentIndex = (widget.pageController.page! + 0.5).toInt();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              CustomPaint(
                size: Size(width, height),
                painter: BottomBarPainter(
                  position: _itemPosByScrollPosition(scrollPosition),
                  color: widget.color,
                  notchColor: widget.notchColor,
                  showShadow: widget.showShadow,
                ),
              ),
              for (var i = 0; i < widget.bottomBarItems.length; i++) ...[
                if (i == currentIndex)
                  Positioned(
                    top: kTopMargin,
                    left: kCircleRadius -
                        kCircleMargin / 2 +
                        _itemPosByScrollPosition(scrollPosition),
                    child: BottomBarActiveItem(
                      i,
                      itemWidget: widget.bottomBarItems[i].activeItem,
                      scrollPosition: scrollPosition,
                      onTap: widget.onTap,
                    ),
                  ),
                if (i != currentIndex)
                  Positioned(
                    top: kMargin / 3 + (kHeight - kCircleRadius * 2) / 2,
                    left: kCircleMargin + _itemPosByIndex(i),
                    child: BottomBarInActiveItem(
                      i,
                      itemWidget: widget.bottomBarItems[i].inActiveItem,
                      label: widget.bottomBarItems[i].itemLabel,
                      onTap: widget.onTap,
                      showLabel: widget.showLabel,
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  double _firstItemPosition() {
    return (_screenWidth) * 0.1;
  }

  double _lastItemPosition() {
    return _screenWidth * 0.9 - (kCircleRadius + kCircleMargin) * 2;
  }

  double _itemDistance() {
    return (_lastItemPosition() - _firstItemPosition()) /
        (widget.bottomBarItems.length - 1);
  }

  double _itemPosByScrollPosition(double scrollPosition) {
    return _firstItemPosition() + _itemDistance() * scrollPosition;
  }

  double _itemPosByIndex(int index) {
    return _firstItemPosition() + _itemDistance() * index;
  }
}

class BottomBarActiveItem extends StatelessWidget {
  const BottomBarActiveItem(
    this.index, {
    required this.itemWidget,
    required this.onTap,
    required this.scrollPosition,
  });

  final int index;
  final Widget itemWidget;
  final double scrollPosition;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final icon = itemWidget;
    return InkWell(
      child: SizedBox.fromSize(
        size: const Size(kIconSize, kIconSize),
        child: Opacity(
            opacity: kPi * 2 * (scrollPosition % 1) == 0 ? 1 : 0, child: icon),
      ),
      onTap: () => onTap(index),
    );
  }
}

class BottomBarPainter extends CustomPainter {
  BottomBarPainter(
      {required this.position,
      required this.color,
      required this.showShadow,
      required this.notchColor})
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true,
        _shadowColor = Colors.grey.shade600,
        _notchPaint = Paint()
          ..color = notchColor
          ..isAntiAlias = true;
  final double position;
  final Color color;
  final Paint _paint;
  final Color _shadowColor;
  final bool showShadow;
  final Paint _notchPaint;
  final Color notchColor;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBar(canvas, size);
    _drawFloatingCircle(canvas);
  }

  @override
  bool shouldRepaint(BottomBarPainter oldDelegate) {
    return position != oldDelegate.position || color != oldDelegate.color;
  }

  void _drawBar(Canvas canvas, Size size) {
    const left = 0.0;
    final right = size.width;
    const top = kMargin;
    const bottom = top + kHeight;

    final path = Path()
      ..moveTo(left + kTopRadius, top)
      ..lineTo(position - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..relativeArcToPoint(
        const Offset((kCircleRadius + kCircleMargin) * 2, 0.0),
        radius: const Radius.circular(kCircleRadius + kCircleMargin),
        clockwise: false,
      )
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(right - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(right, bottom)
      ..lineTo(left, bottom)
      ..lineTo(left, top + kTopRadius)
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      );
    if (showShadow) {
      canvas.drawShadow(path, _shadowColor, 5.0, true);
    }
    canvas.drawPath(path, _paint);
  }

  void _drawFloatingCircle(Canvas canvas) {
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            position + kCircleMargin + kCircleRadius,
            kMargin + kCircleMargin,
          ),
          radius: kCircleRadius,
        ),
        0,
        kPi * 2,
      );
    if (showShadow) {
      canvas.drawShadow(path, _shadowColor, 5.0, true);
    }
    canvas.drawPath(path, _notchPaint);
  }
}

class BottomBarInActiveItem extends StatelessWidget {
  const BottomBarInActiveItem(this.index,
      {required this.itemWidget,
      required this.onTap,
      required this.showLabel,
      this.label,
      this.labelStyle});

  final int index;
  final Widget itemWidget;
  final String? label;
  final bool showLabel;
  final TextStyle? labelStyle;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(kCircleRadius * 2, kCircleRadius * 2),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30, width: 30, child: itemWidget),
            if (label != null && showLabel) ...[
              const SizedBox(height: 5.0),
              Text(
                label!,
                style: labelStyle ??
                    TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13.0,
                    ),
              ),
            ],
          ],
        ),
        onTap: () => onTap(index),
      ),
    );
  }
}

class BottomBarItem {
  const BottomBarItem({
    required this.inActiveItem,
    required this.activeItem,
    this.itemLabel,
  });

  final Widget inActiveItem;
  final Widget activeItem;
  final String? itemLabel;
}
