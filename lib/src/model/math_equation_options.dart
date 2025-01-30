import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class MathEquationOptions {
  final MathOptions? mathOptions;
  final TexParserSettings textParserSettings;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? textScaleFactor;

  const MathEquationOptions({
    this.mathOptions,
    this.textParserSettings = const TexParserSettings(),
    this.padding,
    this.textScaleFactor,
    this.textStyle,
  });
}
