import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/keyboard/models/keyboard_type.dart';

/// 모든 키보드 레이아웃에 공통으로 사용되는 하단 행
class CommonLayout {
  /// 공통 하단 행: ◗(테마) A/1(문자/숫자) space(스페이스) ⇄(한/영) ↵(엔터)
  static List<KeyItem> getRow(Color keyColor, Color bgColor) {
    return [
      spacer(4),
      key('◗', 65, keyColor, bgColor),       // 테마 토글
      spacer(11),
      key('A/1', 65, keyColor, bgColor),     // 문자/숫자 전환
      spacer(11),
      key('space', 350, keyColor, bgColor),  // 스페이스 바
      spacer(11),
      key('⇄', 50, keyColor, bgColor),       // 한글/영문 전환
      spacer(11),
      key('↵', 80, keyColor, bgColor),       // 엔터 (확인)
      spacer(4),
    ];
  }
}