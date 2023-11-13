import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../theme/app_text_theme.dart';

class RowItem extends StatelessWidget {
  final String title;
  final Color? color;
  final bool topRound;
  final bool bottomRound;
  final GestureTapCallback? onTap;
  final Widget? trailing;

  const RowItem({
    Key? key,
    required this.title,
    this.color = Colors.white,
    this.topRound = false,
    this.bottomRound = false,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert((topRound && bottomRound) != true);
    return ListTile(
      tileColor: color,
      shape: topRound
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            )
          : (bottomRound
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                )
              : null),
      title: Text(
        title,
        style: AppTS.normal,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class RowItemOpen extends RowItem {
  final OpenContainerBuilder openBuilder;

  RowItemOpen(
      {super.key,
      required super.title,
      super.topRound,
      super.bottomRound,
      required this.openBuilder});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedElevation: 0,
        closedShape: topRound
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              )
            : (bottomRound
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  )
                : const RoundedRectangleBorder()),
        closedBuilder: (context, action) => super.build(context),
        openBuilder: openBuilder);
  }
}


class DividerContainer extends StatelessWidget {
  final List<RowItem> items;
  final List<Widget> children = [];

  DividerContainer({required this.items, Key? key}) : super(key: key) {
    for (int i = 0; i < items.length; i++) {
      children.add(items[i]);
      if (i != items.length - 1) {
        children.add(
          const Divider(
            height: 0,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children,
    );
  }
}