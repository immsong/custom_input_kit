import 'dart:async';

import 'package:custom_input_kit/src/controller/custom_input_controller.dart';
import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/keyboard/models/keyboard_type.dart';
import 'package:custom_input_kit/src/keyboard/laytouts/common_layout.dart';
import 'package:custom_input_kit/src/keyboard/laytouts/kor_layout.dart';
import 'package:custom_input_kit/src/keyboard/laytouts/eng_layout.dart';
import 'package:custom_input_kit/src/keyboard/laytouts/number_layout.dart';
import 'package:custom_input_kit/src/keyboard/laytouts/symbol_layout.dart';
import 'package:custom_input_kit/src/keyboard/utils/text_parser.dart';

/// 커스텀 키보드 위젯
///
/// 한글, 영문, 숫자, 특수문자 입력을 지원하는 소프트웨어 키보드입니다.
/// CustomInputController를 통해 제어됩니다.
class KeyboardWidget extends StatefulWidget {
  const KeyboardWidget({super.key});

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  /// 현재 활성화된 키보드 타입
  KeyboardType _keyboardType = KeyboardType.kor;

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

  /// 키보드 키 오래 눌렀을 때 연속 입력 처리
  Timer? _longPressTimer;

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
      _inputChars.addAll(TextParser.toCharList(initialValue));

      _inputText = initialValue;
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
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: CustomInputController.instance.isUseDarkTheme
                  ? Colors.grey[800]
                  : Colors.grey[400],
            ),
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
        // 키보드 영역
        Expanded(flex: 5, child: _buildKeyboard()),
      ],
    );
  }

  /// 현재 키보드 타입에 맞는 키보드를 반환합니다.
  Widget _buildKeyboard() {
    if (_keyboardType == KeyboardType.kor) {
      return _buildKorKeyboard(false);
    } else if (_keyboardType == KeyboardType.korShift) {
      return _buildKorKeyboard(true);
    } else if (_keyboardType == KeyboardType.eng) {
      return _buildEngKeyboard(false);
    } else if (_keyboardType == KeyboardType.engShift) {
      return _buildEngKeyboard(true);
    } else if (_keyboardType == KeyboardType.number) {
      return _buildNumberKeyboard(false);
    } else if (_keyboardType == KeyboardType.symbol) {
      return _buildNumberKeyboard(true);
    }
    return const SizedBox.shrink();
  }

  /// 한글 키보드를 빌드합니다.
  ///
  /// [isShift]: true면 쌍자음/복모음 레이아웃
  Widget _buildKorKeyboard(bool isShift) {
    final keyColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.white
        : Colors.black;
    final bgColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.grey[800]!
        : Colors.grey[200]!;

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
              isShift
                  ? KorShiftLayout.getRow1(keyColor, bgColor)
                  : KorLayout.getRow1(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              isShift
                  ? KorShiftLayout.getRow2(keyColor, bgColor)
                  : KorLayout.getRow2(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              isShift
                  ? KorShiftLayout.getRow3(keyColor, bgColor)
                  : KorLayout.getRow3(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(CommonLayout.getRow(keyColor, bgColor)),
          ),
        ],
      ),
    );
  }

  /// 영문 키보드를 반환합니다.
  ///
  /// [isShift]: true면 대문자 레이아웃
  Widget _buildEngKeyboard(bool isShift) {
    final keyColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.white
        : Colors.black;
    final bgColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.grey[800]!
        : Colors.grey[200]!;

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
              isShift
                  ? EngShiftLayout.getRow1(keyColor, bgColor)
                  : EngLayout.getRow1(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              isShift
                  ? EngShiftLayout.getRow2(keyColor, bgColor)
                  : EngLayout.getRow2(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              isShift
                  ? EngShiftLayout.getRow3(keyColor, bgColor)
                  : EngLayout.getRow3(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(CommonLayout.getRow(keyColor, bgColor)),
          ),
        ],
      ),
    );
  }

  /// 숫자/기호 키보드를 반환합니다.
  ///
  /// [isShift]: true면 특수문자 레이아웃
  Widget _buildNumberKeyboard(bool isShift) {
    final keyColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.white
        : Colors.black;
    final bgColor = CustomInputController.instance.isUseDarkTheme
        ? Colors.grey[800]!
        : Colors.grey[200]!;

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
              isShift
                  ? SymbolLayout.getRow1(keyColor, bgColor)
                  : NumberLayout.getRow1(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              isShift
                  ? SymbolLayout.getRow2(keyColor, bgColor)
                  : NumberLayout.getRow2(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(
              isShift
                  ? SymbolLayout.getRow3(keyColor, bgColor)
                  : NumberLayout.getRow3(keyColor, bgColor),
            ),
          ),
          const Spacer(flex: 7),
          Expanded(
            flex: 32,
            child: _buildKeyRow(CommonLayout.getRow(keyColor, bgColor)),
          ),
        ],
      ),
    );
  }

  /// 키 행을 반환합니다.
  Widget _buildKeyRow(List<KeyItem> keys) {
    return Row(children: [...keys.map((key) => _buildKey(key))]);
  }

  /// 키 입력 처리
  void _handleKeyPress(KeyItem key) {
    // 여백(spacer)이면 아무 동작 안 함
    if (key.isSpace) {
      return;
    }

    // Shift 키: 키보드 타입 전환 (소문자 <-> 대문자, 자음/모음 <-> 쌍자음/복모음, 숫자 <-> 기호)
    if (key.txt == '↑') {
      setState(() {
        if (_keyboardType == KeyboardType.kor) {
          _keyboardType = KeyboardType.korShift;
        } else if (_keyboardType == KeyboardType.korShift) {
          _keyboardType = KeyboardType.kor;
        } else if (_keyboardType == KeyboardType.eng) {
          _keyboardType = KeyboardType.engShift;
        } else if (_keyboardType == KeyboardType.engShift) {
          _keyboardType = KeyboardType.eng;
        } else if (_keyboardType == KeyboardType.number) {
          _keyboardType = KeyboardType.symbol;
        } else if (_keyboardType == KeyboardType.symbol) {
          _keyboardType = KeyboardType.number;
        }
      });

      return;
    }

    // 한/영 전환 키
    if (key.txt == '⇄') {
      setState(() {
        if (_keyboardType == KeyboardType.kor) {
          _keyboardType = KeyboardType.eng;
        } else if (_keyboardType == KeyboardType.korShift) {
          _keyboardType = KeyboardType.engShift;
        } else if (_keyboardType == KeyboardType.eng) {
          _keyboardType = KeyboardType.kor;
        } else if (_keyboardType == KeyboardType.engShift) {
          _keyboardType = KeyboardType.korShift;
        }
      });

      return;
    }

    // 문자/숫자 전환 키
    if (key.txt == 'A/1') {
      setState(() {
        if (_keyboardType == KeyboardType.kor) {
          _keyboardType = KeyboardType.number;
        } else if (_keyboardType == KeyboardType.korShift) {
          _keyboardType = KeyboardType.symbol;
        } else if (_keyboardType == KeyboardType.eng) {
          _keyboardType = KeyboardType.number;
        } else if (_keyboardType == KeyboardType.engShift) {
          _keyboardType = KeyboardType.symbol;
        } else if (_keyboardType == KeyboardType.number) {
          _keyboardType = KeyboardType.eng;
        } else if (_keyboardType == KeyboardType.symbol) {
          _keyboardType = KeyboardType.engShift;
        }
      });

      return;
    }

    // 테마 토글 키 (다크/라이트 모드)
    if (key.txt == '◗') {
      setState(() {
        CustomInputController.instance.setIsUseDarkTheme(
          !CustomInputController.instance.isUseDarkTheme,
        );
      });
      return;
    }

    // 엔터 키: 입력 완료 및 키보드 닫기
    if (key.txt == '↵') {
      final controller = CustomInputController.instance;
      controller.setValue(_inputText);
      controller.hide();
      return;
    }

    // 스페이스바 키
    if (key.txt == 'space') {
      setState(() {
        _inputChars.add(' ');
      });
    }
    // 백스페이스 키
    else if (key.txt == '←') {
      if (_inputChars.isNotEmpty) {
        setState(() {
          _inputChars.removeLast();
        });
      }
    }
    // 일반 문자 입력
    else {
      setState(() {
        _inputChars.add(key.txt);
      });
    }

    // 키 배열을 완성형 문자로 조합
    setState(() {
      _inputText = TextParser.parse(_inputChars);
    });
  }

  /// 키 입력 처리 완료 후 초기화
  void _cleanUpKeyInput() {
    setState(() {
      if (_pressedKey != '↑') {
        if (_keyboardType == KeyboardType.korShift) {
          _keyboardType = KeyboardType.kor;
        } else if (_keyboardType == KeyboardType.engShift) {
          _keyboardType = KeyboardType.eng;
        }
      }

      _pressedKey = '';
    });
  }

  /// 개별 키를 반환하고 이벤트를 처리합니다.
  Widget _buildKey(KeyItem key) {
    return Expanded(
      flex: key.flex,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxHeight;
          return GestureDetector(
            onTapDown: (_) {
              setState(() {
                _pressedKey = key.txt;
              });

              // 장시간 눌렀을 때 연속 입력 처리, 500ms 이상 눌렀을 때 연속 입력 처리
              _longPressTimer = Timer.periodic(Duration(milliseconds: 500), (
                timer,
              ) {
                _longPressTimer!.cancel();
                // 연속 입력 처리, 50ms마다 입력 처리
                _longPressTimer = Timer.periodic(Duration(milliseconds: 50), (
                  timer,
                ) {
                  _handleKeyPress(key);
                });
              });
            },
            onTapCancel: () {
              _longPressTimer?.cancel();
              _cleanUpKeyInput();
            },
            onTapUp: (_) {
              _longPressTimer?.cancel();
              _handleKeyPress(key);
              _cleanUpKeyInput();
            },
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(size * 0.2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // 눌렸을 때 색상 반전
                color: _pressedKey == key.txt ? key.txtColor : key.bgColor,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  key.txt,
                  style: TextStyle(
                    // 눌렸을 때 색상 반전
                    color: _pressedKey == key.txt ? key.bgColor : key.txtColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
