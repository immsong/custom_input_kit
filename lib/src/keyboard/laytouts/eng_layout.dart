import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/keyboard/models/keyboard_type.dart';

/// 영문 키보드 레이아웃 (QWERTY)
class EngLayout {
  /// 첫 번째 줄: qwertyuiop
  static List<KeyItem> getRow1(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('q', 62, keyColor, bgColor),
      spacer(11),
      key('w', 62, keyColor, bgColor),
      spacer(11),
      key('e', 62, keyColor, bgColor),
      spacer(11),
      key('r', 62, keyColor, bgColor),
      spacer(11),
      key('t', 62, keyColor, bgColor),
      spacer(11),
      key('y', 62, keyColor, bgColor),
      spacer(11),
      key('u', 62, keyColor, bgColor),
      spacer(11),
      key('i', 62, keyColor, bgColor),
      spacer(11),
      key('o', 62, keyColor, bgColor),
      spacer(11),
      key('p', 62, keyColor, bgColor),
      spacer(4),
    ];
  }

  /// 두 번째 줄: asdfghjkl
  static List<KeyItem> getRow2(Color keyColor, Color bgColor) {
    return [
      spacer(36),
      key('a', 62, keyColor, bgColor),
      spacer(11),
      key('s', 62, keyColor, bgColor),
      spacer(11),
      key('d', 62, keyColor, bgColor),
      spacer(11),
      key('f', 62, keyColor, bgColor),
      spacer(11),
      key('g', 62, keyColor, bgColor),
      spacer(11),
      key('h', 62, keyColor, bgColor),
      spacer(11),
      key('j', 62, keyColor, bgColor),
      spacer(11),
      key('k', 62, keyColor, bgColor),
      spacer(11),
      key('l', 62, keyColor, bgColor),
      spacer(36),
    ];
  }

  /// 세 번째 줄: ↑zxcvbnm←
  static List<KeyItem> getRow3(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('↑', 76, keyColor, bgColor),
      spacer(23),
      key('z', 62, keyColor, bgColor),
      spacer(11),
      key('x', 62, keyColor, bgColor),
      spacer(11),
      key('c', 62, keyColor, bgColor),
      spacer(11),
      key('v', 62, keyColor, bgColor),
      spacer(11),
      key('b', 62, keyColor, bgColor),
      spacer(11),
      key('n', 62, keyColor, bgColor),
      spacer(11),
      key('m', 62, keyColor, bgColor),
      spacer(23),
      key('←', 76, keyColor, bgColor),
      spacer(4),
    ];
  }
}

/// 영문 Shift 키보드 레이아웃 (대문자)
class EngShiftLayout {
  /// 첫 번째 줄: QWERTYUIOP
  static List<KeyItem> getRow1(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('Q', 62, keyColor, bgColor),
      spacer(11),
      key('W', 62, keyColor, bgColor),
      spacer(11),
      key('E', 62, keyColor, bgColor),
      spacer(11),
      key('R', 62, keyColor, bgColor),
      spacer(11),
      key('T', 62, keyColor, bgColor),
      spacer(11),
      key('Y', 62, keyColor, bgColor),
      spacer(11),
      key('U', 62, keyColor, bgColor),
      spacer(11),
      key('I', 62, keyColor, bgColor),
      spacer(11),
      key('O', 62, keyColor, bgColor),
      spacer(11),
      key('P', 62, keyColor, bgColor),
      spacer(4),
    ];
  }

  /// 두 번째 줄: ASDFGHJKL
  static List<KeyItem> getRow2(Color keyColor, Color bgColor) {
    return [
      spacer(36),
      key('A', 62, keyColor, bgColor),
      spacer(11),
      key('S', 62, keyColor, bgColor),
      spacer(11),
      key('D', 62, keyColor, bgColor),
      spacer(11),
      key('F', 62, keyColor, bgColor),
      spacer(11),
      key('G', 62, keyColor, bgColor),
      spacer(11),
      key('H', 62, keyColor, bgColor),
      spacer(11),
      key('J', 62, keyColor, bgColor),
      spacer(11),
      key('K', 62, keyColor, bgColor),
      spacer(11),
      key('L', 62, keyColor, bgColor),
      spacer(36),
    ];
  }

  /// 세 번째 줄: ↑ZXCVBNM← (Shift 활성화 상태)
  static List<KeyItem> getRow3(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('↑', 76, bgColor, keyColor), // 색상 반전 (활성화 표시)
      spacer(23),
      key('Z', 62, keyColor, bgColor),
      spacer(11),
      key('X', 62, keyColor, bgColor),
      spacer(11),
      key('C', 62, keyColor, bgColor),
      spacer(11),
      key('V', 62, keyColor, bgColor),
      spacer(11),
      key('B', 62, keyColor, bgColor),
      spacer(11),
      key('N', 62, keyColor, bgColor),
      spacer(11),
      key('M', 62, keyColor, bgColor),
      spacer(23),
      key('←', 76, keyColor, bgColor),
      spacer(4),
    ];
  }
}