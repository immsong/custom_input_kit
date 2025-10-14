import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/keyboard/models/keyboard_type.dart';

/// 한글 키보드 레이아웃 (2벌식 표준)
class KorLayout {
  /// 첫 번째 줄: ㅂㅈㄷㄱㅅㅛㅕㅑㅐㅔ
  static List<KeyItem> getRow1(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('ㅂ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅈ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄷ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄱ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅅ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅛ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅕ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅑ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅐ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅔ', 62, keyColor, bgColor),
      spacer(4),
    ];
  }

  /// 두 번째 줄: ㅁㄴㅇㄹㅎㅗㅓㅏㅣ
  static List<KeyItem> getRow2(Color keyColor, Color bgColor) {
    return [
      spacer(36),
      key('ㅁ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄴ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅇ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄹ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅎ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅗ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅓ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅏ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅣ', 62, keyColor, bgColor),
      spacer(36),
    ];
  }

  /// 세 번째 줄: ↑ㅋㅌㅊㅍㅠㅜㅡ←
  static List<KeyItem> getRow3(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('↑', 76, keyColor, bgColor),
      spacer(23),
      key('ㅋ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅌ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅊ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅍ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅠ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅜ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅡ', 62, keyColor, bgColor),
      spacer(23),
      key('←', 76, keyColor, bgColor),
      spacer(4),
    ];
  }
}

/// 한글 Shift 키보드 레이아웃 (쌍자음, 복모음)
class KorShiftLayout {
  /// 첫 번째 줄: ㅃㅉㄸㄲㅆㅛㅕㅑㅒㅖ
  static List<KeyItem> getRow1(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('ㅃ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅉ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄸ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄲ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅆ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅛ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅕ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅑ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅒ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅖ', 62, keyColor, bgColor),
      spacer(4),
    ];
  }

  /// 두 번째 줄: ㅁㄴㅇㄹㅎㅗㅓㅏㅣ
  static List<KeyItem> getRow2(Color keyColor, Color bgColor) {
    return [
      spacer(36),
      key('ㅁ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄴ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅇ', 62, keyColor, bgColor),
      spacer(11),
      key('ㄹ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅎ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅗ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅓ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅏ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅣ', 62, keyColor, bgColor),
      spacer(36),
    ];
  }

  /// 세 번째 줄: ↑ㅋㅌㅊㅍㅠㅜㅡ← (Shift 활성화 상태)
  static List<KeyItem> getRow3(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('↑', 76, bgColor, keyColor), // 색상 반전 (활성화 표시)
      spacer(23),
      key('ㅋ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅌ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅊ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅍ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅠ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅜ', 62, keyColor, bgColor),
      spacer(11),
      key('ㅡ', 62, keyColor, bgColor),
      spacer(23),
      key('←', 76, keyColor, bgColor),
      spacer(4),
    ];
  }
}