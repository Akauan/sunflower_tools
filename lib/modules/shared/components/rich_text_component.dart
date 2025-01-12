import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class RichTextComponent extends StatelessWidget {
  final int maxLines;
  final double minFontSize;
  final double maxFontSize;
  final Color? color;
  final TextSpan textSpan;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  const RichTextComponent({
    super.key,
    this.maxLines = 1,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.color,
    required this.textSpan,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color ?? ThemeColor.greyColor,
      ),
      TextSpan(
        children: <TextSpan>[textSpan],
      ),
    );
  }
}
