import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/keyboard/models/keyboard_type.dart';

/// 특수문자 키보드 레이아웃
class SymbolLayout {
  /// 첫 번째 줄: !@#$%^&*()
  static List<KeyItem> getRow1(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('!', 62, keyColor, bgColor),
      spacer(11),
      key('@', 62, keyColor, bgColor),
      spacer(11),
      key('#', 62, keyColor, bgColor),
      spacer(11),
      key('\$', 62, keyColor, bgColor),
      spacer(11),
      key('%', 62, keyColor, bgColor),
      spacer(11),
      key('^', 62, keyColor, bgColor),
      spacer(11),
      key('&', 62, keyColor, bgColor),
      spacer(11),
      key('*', 62, keyColor, bgColor),
      spacer(11),
      key('(', 62, keyColor, bgColor),
      spacer(11),
      key(')', 62, keyColor, bgColor),
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

  /// 세 번째 줄: ↑,<.>/?← (Shift 활성화 상태)
  static List<KeyItem> getRow3(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('↑', 76, bgColor, keyColor), // Shift 활성화 상태
      spacer(23),
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
      spacer(23),
      key('←', 76, keyColor, bgColor),
      spacer(4),
    ];
  }
}
