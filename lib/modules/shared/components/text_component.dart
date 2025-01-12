import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final double? size;
  final TextOverflow? overflow;
  final double minFontSize;
  final double maxFontSize;
  final int lines;
  final Color? color;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const TextComponent({
    super.key,
    required this.text,
    this.size = 12,
    this.overflow = TextOverflow.ellipsis,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.lines = 1,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      overflow: overflow,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      maxLines: lines,
      textAlign: textAlign,
      text,
      style: TextStyle(
        color: color ?? ThemeColor.primaryColor,
        fontWeight: fontWeight,
        fontSize: size,
      ),
    );
  }
}
