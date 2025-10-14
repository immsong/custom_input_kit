import 'dart:async';

import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/models/input_type.dart';

/// Custom Input Kit의 전역 컨트롤러.
///
/// 싱글톤 패턴으로 구현되어 앱 전체에서 하나의 인스턴스만 사용합니다.
/// 키보드 표시/숨김, 입력값 관리, 테마 설정 등을 담당합니다.
///
/// 사용 예시:
/// ```dart
/// // 키보드 표시
/// CustomInputController.instance.show(InputType.keyboard);
///
/// // 결과값을 받아야 할 때
/// final result = await CustomInputController.instance.showWithResult(InputType.keyboard);
/// ```
class CustomInputController extends ChangeNotifier {
  static final instance = CustomInputController._();
  CustomInputController._();

  /// 사용자가 입력한 최종 값
  Object? _value;
  Object? get value => _value;

  Completer<Object?>? _completer;

  /// 입력 위젯이 현재 활성화(표시) 상태인지 여부
  bool _isActive = false;
  bool get isActive => _isActive;

  /// 현재 표시 중인 입력 타입 (keyboard, calendar 등)
  InputType _type = InputType.keyboard;
  InputType get type => _type;

  /// 다크 테마 사용 여부
  bool _isUseDarkTheme = true;
  bool get isUseDarkTheme => _isUseDarkTheme;

  /// 키보드 높이 비율 (Flex 값)
  /// 10: 전체 화면, 5: 화면 절반, 4: 기본값 (약 40%)
  int _keyboardFlex = 4;
  int get keyboardFlex => _keyboardFlex;

  /// 키보드 초기 텍스트 (편집 모드에서 사용)
  String _initialText = "";
  String get initialText => _initialText;

  /// 입력 위젯을 표시합니다.
  ///
  /// [type]: 표시할 입력 타입
  /// [initialText]: 키보드의 초기 텍스트 (선택사항)
  ///
  /// 결과값이 필요하지 않을 때 사용합니다.
  void show(InputType type, {String initialText = ""}) {
    _type = type;
    _isActive = true;
    _initialText = initialText;
    notifyListeners();
  }

  /// 입력 위젯을 표시하고 사용자 입력을 기다립니다.
  ///
  /// [type]: 표시할 입력 타입
  /// [initialText]: 키보드의 초기 텍스트 (선택사항)
  ///
  /// 반환값: 사용자가 입력한 값 (취소 시 null)
  ///
  /// 사용자가 입력을 완료하거나 취소할 때까지 대기합니다.
  Future<Object?> showWithResult(InputType type, {String initialText = ""}) {
    _type = type;
    _isActive = true;
    _initialText = initialText;
    _completer = Completer<Object?>();
    notifyListeners();
    return _completer!.future;
  }

  /// 입력 위젯을 숨깁니다 (취소).
  ///
  /// 사용자가 입력을 취소했을 때 사용합니다.
  /// showWithResult()를 사용했다면 null을 반환합니다.
  void hide() {
    _isActive = false;
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete(null);
    }
    notifyListeners();
  }

  /// 입력값을 설정합니다 (완료).
  ///
  /// [value]: 사용자가 입력한 값
  ///
  /// 사용자가 입력을 완료했을 때 사용합니다.
  /// showWithResult()를 사용했다면 해당 값을 반환합니다.
  void setValue(Object? value) {
    _value = value;
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete(value);
    }
    notifyListeners();
  }

  /// 테마를 변경합니다.
  ///
  /// [isUseDarkTheme]: true면 다크 테마, false면 라이트 테마
  void setIsUseDarkTheme(bool isUseDarkTheme) {
    _isUseDarkTheme = isUseDarkTheme;
    notifyListeners();
  }

  /// 키보드 높이 비율을 설정합니다.
  ///
  /// [keyboardFlex]: Flex 값 (기본값: 4)
  void setKeyboardFlex(int keyboardFlex) {
    _keyboardFlex = keyboardFlex;
    notifyListeners();
  }
}