import 'package:flutter/material.dart';

/// 키보드 레이아웃 타입
enum KeyboardType {
  kor, // 한글
  korShift, // 한글 Shift (쌍자음, 복모음)
  eng, // 영문 소문자
  engShift, // 영문 대문자
  number, // 숫자
  symbol // 특수문자
}

/// 키보드의 개별 키 또는 여백을 나타내는 모델
class KeyItem {
  /// 여백 여부 (true: 빈 공간, false: 실제 키)
  final bool isSpace;

  /// 키에 표시될 텍스트
  final String txt;

  /// 레이아웃에서 차지할 비율 (Flex 값)
  final int flex;

  /// 텍스트 색상
  Color txtColor;

  /// 배경 색상
  Color bgColor;

  KeyItem({
    this.isSpace = true,
    this.txt = "",
    required this.flex,
    this.txtColor = Colors.transparent,
    this.bgColor = Colors.transparent,
  });
}

/// 실제 키를 생성하는 헬퍼 함수
KeyItem key(String txt, int flex, Color txtColor, Color bgColor) {
  return KeyItem(
      txt: txt,
      flex: flex,
      txtColor: txtColor,
      bgColor: bgColor,
      isSpace: false);
}

/// 여백을 생성하는 헬퍼 함수
KeyItem spacer(int flex) {
  return KeyItem(flex: flex);
}
