import 'dart:async';

import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/controller/custom_input_controller.dart';
import 'package:custom_input_kit/src/number/utils/number_parser.dart';

/// 숫자 입력을 위한 커스텀 키보드 위젯
///
/// 숫자 및 소수점 입력을 지원하는 소프트웨어 키보드입니다.
/// NumberParser를 통해 입력 유효성을 검증합니다.
class NumberWidget extends StatefulWidget {
  const NumberWidget({super.key, this.isFloat = true});

  /// 소수점 입력 허용 여부
  final bool isFloat;

  @override
  State<NumberWidget> createState() => _NumberWidgetState();
}

class _NumberWidgetState extends State<NumberWidget> {
  /// 입력된 키 배열
  final List<String> _inputChars = [];

  /// 조합된 최종 텍스트
  String _inputText = '';

  /// 현재 눌린 키 (눌림 상태 표시를 위함)
  String _pressedKey = '';

  /// 커서 깜박임 타이머
  Timer? _cursorTimer;

  /// 커서 표시 여부
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    _cursorTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _showCursor = !_showCursor;
      });
    });

    if (CustomInputController.instance.initialValue is String) {
      String initialValue =
          CustomInputController.instance.initialValue as String;
      _inputChars.addAll(initialValue.split(''));
      _inputText = initialValue;
    }

    if (double.tryParse(_inputText) == null) {
      _inputText = '0';
      _inputChars.clear();
      _inputChars.add('0');
    }
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 입력 텍스트 표시 영역
        Expanded(
          child: Container(
            color: CustomInputController.instance.isUseDarkTheme
                ? Colors.grey[800]
                : Colors.grey[400],
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.keyboard, color: Colors.black),
                          SizedBox(width: 10),
                          Expanded(
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.contain,
                              child: Text(
                                _showCursor ? '$_inputText|' : '$_inputText ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        // 숫자 키보드 영역
        Expanded(flex: 5, child: _buildNumberKeyboard()),
      ],
    );
  }

  /// 숫자 키보드를 반환합니다.
  Widget _buildNumberKeyboard() {
    return Container(
      padding: EdgeInsets.all(10),
      color: CustomInputController.instance.isUseDarkTheme
          ? Colors.grey[900]
          : Colors.grey[500],
      child: Column(
        children: [
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              ['\t\t\t\t\t', '1', '', '2', '', '3', '\t\t\t\t\t'],
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              ['\t\t\t\t\t', '4', '', '5', '', '6', '\t\t\t\t\t'],
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              ['\t\t\t\t\t', '7', '', '8', '', '9', '\t\t\t\t\t'],
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              ['\t\t\t\t\t', '.', '', '0', '', '←', '\t\t\t\t\t'],
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
                ['\t\t\t\t\t', '\t', '', '◗', '', '↵', '\t\t\t\t\t']),
          ),
        ],
      ),
    );
  }

  /// 키 행을 반환합니다.
  Widget _buildKeyRow(List<String> keys) {
    final keyColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.white
        : Colors.black;
    final bgColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.grey[800]!
        : Colors.grey[200]!;
    return Row(
        children: [...keys.map((key) => _buildKey(key, keyColor, bgColor))]);
  }

  /// 키 입력 처리
  void _handleKeyPress(String key) {
    // integer 상태일 경우 '.' 동작 안하도록 설정
    if (key == '.' && !widget.isFloat) {
      return;
    }

    // 테마 토글 키 (다크/라이트 모드)
    if (key == '◗') {
      setState(() {
        CustomInputController.instance.setIsUseDarkTheme(
          !CustomInputController.instance.isUseDarkTheme,
        );
      });
      return;
    }

    // 엔터 키: 입력 완료 및 키보드 닫기
    if (key == '↵') {
      // '.' 으로 종료 될 경우 해당 '.' 제거
      if (_inputText.endsWith(".")) {
        _inputText = _inputText.substring(0, _inputText.length - 1);
      }

      // 문자열에 비어있을 경우 0으로 처리
      if (_inputText.isEmpty) {
        _inputText = '0';
      }

      final controller = CustomInputController.instance;
      controller.setValue(_inputText);
      controller.hide();
      return;
    }

    if (key == '←') {
      if (_inputChars.isNotEmpty) {
        _inputChars.removeLast();
      }
    } else {
      _inputChars.add(key);
    }

    setState(() {
      var parsedNum = NumberParser.parse(_inputChars);
      _inputChars.clear();
      _inputChars.addAll(parsedNum);
      _inputText = _inputChars.join('');
    });
  }

  /// 키 입력 처리 완료 후 초기화
  void _cleanUpKeyInput() {
    setState(() {
      _pressedKey = '';
    });
  }

  /// 개별 키를 반환하고 이벤트를 처리합니다.
  Widget _buildKey(String key, Color txtColor, Color bgColor) {
    if (key.isEmpty) {
      // 가로 10의 공간
      return _buildSpace(10);
    } else if (key.contains('\t')) {
      // \t 개수만큼 Space Flex 설정
      return _buildSpacer(key.split('\t').length);
    }
    // key 의 기본 felx = 2
    return _buildNumKey(key, txtColor, bgColor);
  }

  Widget _buildNumKey(String key, Color txtColor, Color bgColor) {
    return Expanded(
      flex: 2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxHeight;
          return GestureDetector(
            onTapDown: (_) {
              // integer 상태일 경우 '.' 동작 안하도록 설정
              if (key == '.' && !widget.isFloat) {
                return;
              }

              setState(() {
                _pressedKey = key;
              });
            },
            onTapCancel: () {
              _cleanUpKeyInput();
            },
            onTapUp: (_) {
              _handleKeyPress(key);
              _cleanUpKeyInput();
            },
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(size * 0.2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // 눌렸을 때 색상 반전
                color: _pressedKey == key ? txtColor : bgColor,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  key,
                  style: TextStyle(
                    // 눌렸을 때 색상 반전
                    color: _pressedKey == key ? bgColor : txtColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpacer(int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        height: double.infinity,
        color: Colors.transparent,
      ),
    );
  }

  Widget _buildSpace(int size) {
    return SizedBox(width: size.toDouble());
  }
}
