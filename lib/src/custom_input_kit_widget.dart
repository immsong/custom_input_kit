import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/controller/custom_input_controller.dart';
import 'package:custom_input_kit/src/keyboard/keyboard_widget.dart';
import 'package:custom_input_kit/src/models/input_type.dart';

/// Custom Input Kit의 메인 위젯
///
/// 화면 전체를 오버레이하여 입력 위젯을 표시합니다.
/// CustomInputController의 상태 변화를 리스닝하여 자동으로 표시/숨김 처리됩니다.
///
/// 사용 방법:
/// ```dart
/// MaterialApp(
///   builder: (context, child) {
///     return Stack(
///       children: [
///         child!,
///         const CustomInputKitWidget(),
///       ],
///     );
///   },
///   home: YourHomePage(),
/// )
/// ```

class CustomInputKitWidget extends StatefulWidget {
  const CustomInputKitWidget({super.key});

  @override
  State<CustomInputKitWidget> createState() => _CustomInputKitWidgetState();
}

class _CustomInputKitWidgetState extends State<CustomInputKitWidget> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CustomInputController.instance,
      builder: (context, _) {
        final controller = CustomInputController.instance;

        // 비활성화 상태면 빈 위젯 반환
        if (!controller.isActive) {
          return const SizedBox.shrink();
        }

        // 활성화 상태: 전체 화면 오버레이 표시
        return Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                // 상단 영역: 탭하면 키보드 닫힘 (반투명 배경)
                Expanded(
                  flex: 10 - controller.keyboardFlex,
                  child: GestureDetector(
                    onTap: () {
                      controller.hide();
                    },
                    child: Container(color: Colors.black.withAlpha(30)),
                  ),
                ),
                // 하단 영역: 입력 위젯 (키보드, 달력 등)
                Expanded(
                  flex: controller.keyboardFlex,
                  child: _buildInputTypeWidget(controller.type),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 입력 타입에 맞는 위젯을 반환합니다.
  ///
  /// [type]: 표시할 입력 타입 (keyboard, calendar 등)
  Widget _buildInputTypeWidget(InputType type) {
    switch (type) {
      case InputType.keyboard:
        return KeyboardWidget();
      // default:
      //   return const SizedBox.shrink();
    }
  }
}
