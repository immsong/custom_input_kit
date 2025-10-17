import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/keyboard/models/keyboard_type.dart';

/// 숫자 키보드 레이아웃
class NumberLayout {
  /// 첫 번째 줄: 1234567890
  static List<KeyItem> getRow1(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('1', 62, keyColor, bgColor),
      spacer(11),
      key('2', 62, keyColor, bgColor),
      spacer(11),
      key('3', 62, keyColor, bgColor),
      spacer(11),
      key('4', 62, keyColor, bgColor),
      spacer(11),
      key('5', 62, keyColor, bgColor),
      spacer(11),
      key('6', 62, keyColor, bgColor),
      spacer(11),
      key('7', 62, keyColor, bgColor),
      spacer(11),
      key('8', 62, keyColor, bgColor),
      spacer(11),
      key('9', 62, keyColor, bgColor),
      spacer(11),
      key('0', 62, keyColor, bgColor),
      spacer(4),
    ];
  }

  /// 두 번째 줄: -_=+[{]}\|
  static List<KeyItem> getRow2(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('-', 62, keyColor, bgColor),
      spacer(11),
      key('_', 62, keyColor, bgColor),
      spacer(11),
      key('=', 62, keyColor, bgColor),
      spacer(11),
      key('+', 62, keyColor, bgColor),
      spacer(11),
      key('[', 62, keyColor, bgColor),
      spacer(11),
      key('{', 62, keyColor, bgColor),
      spacer(11),
      key(']', 62, keyColor, bgColor),
      spacer(11),
      key('}', 62, keyColor, bgColor),
      spacer(11),
      key('\\', 62, keyColor, bgColor),
      spacer(11),
      key('|', 62, keyColor, bgColor),
      spacer(4),
    ];
  }

  /// 세 번째 줄: ↑,<.>/?←
  static List<KeyItem> getRow3(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('↑', 62, keyColor, bgColor),
      spacer(11),
      key('`', 62, keyColor, bgColor),
      spacer(11),
      key('~', 62, keyColor, bgColor),
      spacer(11),
      key(',', 62, keyColor, bgColor),
      spacer(11),
      key('<', 62, keyColor, bgColor),
      spacer(11),
      key('.', 62, keyColor, bgColor),
      spacer(11),
      key('>', 62, keyColor, bgColor),
      spacer(11),
      key('/', 62, keyColor, bgColor),
      spacer(11),
      key('?', 62, keyColor, bgColor),
      spacer(11),
      key('←', 62, keyColor, bgColor),
      spacer(4),
    ];
  }
}
