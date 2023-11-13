import 'package:flutter/material.dart';

class LinesTextItem extends StatelessWidget {
  final CrossAxisAlignment textAlign;
  final List<String> texts;
  final List<TextStyle>? styles;
  final TextStyle? defaultStyle;
  final Color? textColor;
  final EdgeInsetsGeometry padding;

  const LinesTextItem(
      {this.defaultStyle,
      required this.texts,
      this.styles,
      this.textColor,
      this.padding = const EdgeInsets.all(0),
      this.textAlign = CrossAxisAlignment.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextStyle?> tStyles = [];
    if (styles == null) {
      tStyles = List.generate(
          texts.length, (index) => defaultStyle?.copyWith(color: textColor));
    } else {
      tStyles.addAll(styles!);
      while (tStyles.length < texts.length) {
        tStyles.add(defaultStyle?.copyWith(color: textColor));
      }
    }
    assert(tStyles.length == texts.length);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: textAlign,
      children: List.generate(
        texts.length,
        (index) => Padding(
          padding:padding,
          child: Text(
            texts[index],
            style: tStyles[index],
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
