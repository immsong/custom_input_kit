import 'package:flutter_test/flutter_test.dart';
import 'package:custom_input_kit/src/keyboard/utils/text_parser.dart';
import 'package:custom_input_kit/src/controller/custom_input_controller.dart';
import 'package:custom_input_kit/src/models/input_type.dart';

void main() {
  group('TextParser - 한글 조합', () {
    test('기본 한글 조합', () {
      expect(TextParser.parse(['ㅎ', 'ㅏ', 'ㄴ']), '한');
      expect(TextParser.parse(['ㄱ', 'ㅡ', 'ㄹ']), '글');
      expect(TextParser.parse(['ㅂ', 'ㅏ', 'ㅂ']), '밥');
    });

    test('복합 모음 조합', () {
      expect(TextParser.parse(['ㅎ', 'ㅗ', 'ㅏ']), '화');
      expect(TextParser.parse(['ㄱ', 'ㅜ', 'ㅓ']), '궈');
      expect(TextParser.parse(['ㄱ', 'ㅗ', 'ㅐ']), '괘');
    });

    test('겹받침 조합', () {
      expect(TextParser.parse(['ㄷ', 'ㅏ', 'ㄹ', 'ㄱ']), '닭');
      expect(TextParser.parse(['ㄱ', 'ㅏ', 'ㅂ', 'ㅅ']), '값');
      expect(TextParser.parse(['ㄷ', 'ㅏ', 'ㄹ', 'ㅎ']), '닳');
    });

    test('여러 글자 조합', () {
      expect(TextParser.parse(['ㅎ', 'ㅏ', 'ㄴ', 'ㄱ', 'ㅡ', 'ㄹ']), '한글');
      expect(TextParser.parse(['ㅌ', 'ㅔ', 'ㅅ', 'ㅡ', 'ㅌ', 'ㅡ']), '테스트');
    });

    test('영문/숫자 혼합', () {
      expect(TextParser.parse(['h', 'e', 'l', 'l', 'o']), 'hello');
      expect(TextParser.parse(['ㅎ', 'ㅏ', 'ㄴ', '1', '2', '3']), '한123');
      expect(TextParser.parse(['a', 'b', 'c', 'ㄱ', 'ㅏ']), 'abc가');
    });

    test('단독 자음/모음', () {
      expect(TextParser.parse(['ㅎ']), 'ㅎ');
      expect(TextParser.parse(['ㅏ']), 'ㅏ');
      expect(TextParser.parse(['ㄱ', 'ㅏ', 'ㄴ', 'ㅏ']), '가나');
    });

    test('빈 입력', () {
      expect(TextParser.parse([]), '');
    });
  });

  group('TextParser - 한글 분해', () {
    test('완성형 한글 분해', () {
      expect(TextParser.toCharList('한'), ['ㅎ', 'ㅏ', 'ㄴ']);
      expect(TextParser.toCharList('글'), ['ㄱ', 'ㅡ', 'ㄹ']);
      expect(TextParser.toCharList('가'), ['ㄱ', 'ㅏ']);
    });

    test('복합 모음 분해', () {
      expect(TextParser.toCharList('화'), ['ㅎ', 'ㅗ', 'ㅏ']);
      expect(TextParser.toCharList('궈'), ['ㄱ', 'ㅜ', 'ㅓ']);
      expect(TextParser.toCharList('의'), ['ㅇ', 'ㅡ', 'ㅣ']);
    });

    test('겹받침 분해', () {
      expect(TextParser.toCharList('닭'), ['ㄷ', 'ㅏ', 'ㄹ', 'ㄱ']);
      expect(TextParser.toCharList('값'), ['ㄱ', 'ㅏ', 'ㅂ', 'ㅅ']);
      expect(TextParser.toCharList('흙'), ['ㅎ', 'ㅡ', 'ㄹ', 'ㄱ']);
    });

    test('여러 글자 분해', () {
      expect(TextParser.toCharList('한글'), ['ㅎ', 'ㅏ', 'ㄴ', 'ㄱ', 'ㅡ', 'ㄹ']);
    });

    test('영문/숫자는 그대로', () {
      expect(TextParser.toCharList('hello'), ['h', 'e', 'l', 'l', 'o']);
      expect(TextParser.toCharList('한123'), ['ㅎ', 'ㅏ', 'ㄴ', '1', '2', '3']);
    });

    test('빈 문자열', () {
      expect(TextParser.toCharList(''), []);
    });
  });

  group('TextParser - 유틸리티', () {
    test('자음 확인', () {
      expect(TextParser.isConsonant('ㄱ'), true);
      expect(TextParser.isConsonant('ㅎ'), true);
      expect(TextParser.isConsonant('ㅏ'), false);
      expect(TextParser.isConsonant('a'), false);
    });

    test('모음 확인', () {
      expect(TextParser.isVowel('ㅏ'), true);
      expect(TextParser.isVowel('ㅣ'), true);
      expect(TextParser.isVowel('ㄱ'), false);
      expect(TextParser.isVowel('a'), false);
    });

    test('완성형 한글 확인', () {
      expect(TextParser.isCompleteKorean('한'), true);
      expect(TextParser.isCompleteKorean('가'), true);
      expect(TextParser.isCompleteKorean('ㅎ'), false);
      expect(TextParser.isCompleteKorean('a'), false);
      expect(TextParser.isCompleteKorean(''), false);
    });

    test('한글 조합 (compose)', () {
      expect(TextParser.compose('ㄱ', 'ㅏ'), '가');
      expect(TextParser.compose('ㅎ', 'ㅏ', 'ㄴ'), '한');
      expect(TextParser.compose('ㄷ', 'ㅏ', 'ㄺ'), '닭');
    });

    test('한글 분해 (decompose)', () {
      final (first, second, third) = TextParser.decompose('한');
      expect(first, 'ㅎ');
      expect(second, 'ㅏ');
      expect(third, 'ㄴ');

      final (first2, second2, third2) = TextParser.decompose('가');
      expect(first2, 'ㄱ');
      expect(second2, 'ㅏ');
      expect(third2, null);
    });
  });

  group('CustomInputController', () {
    late CustomInputController controller;

    setUp(() {
      controller = CustomInputController.instance;
      // 테스트 전 초기화
      if (controller.isActive) {
        controller.hide();
      }
    });

    test('싱글톤 인스턴스', () {
      expect(CustomInputController.instance, same(controller));
    });

    test('초기 상태는 비활성화', () {
      expect(controller.isActive, false);
    });

    test('show() 호출 시 활성화', () {
      controller.show(InputType.keyboard);
      expect(controller.isActive, true);
      expect(controller.type, InputType.keyboard);
    });

    test('show()에 initialText 전달', () {
      controller.show(InputType.keyboard, initialText: '테스트');
      expect(controller.isActive, true);
      expect(controller.initialText, '테스트');
    });

    test('hide() 호출 시 비활성화', () {
      controller.show(InputType.keyboard);
      expect(controller.isActive, true);
      
      controller.hide();
      expect(controller.isActive, false);
    });

    test('setValue()로 값 설정', () {
      controller.setValue('테스트');
      expect(controller.value, '테스트');
    });

    test('테마 변경', () {
      final initialTheme = controller.isUseDarkTheme;
      controller.setIsUseDarkTheme(!initialTheme);
      expect(controller.isUseDarkTheme, !initialTheme);
      
      // 원래대로 복원
      controller.setIsUseDarkTheme(initialTheme);
    });

    test('keyboardFlex 변경', () {
      controller.setKeyboardFlex(5);
      expect(controller.keyboardFlex, 5);
      
      // 기본값으로 복원
      controller.setKeyboardFlex(4);
    });

    test('showWithResult()는 Future 반환', () async {
      final future = controller.showWithResult(InputType.keyboard);
      expect(controller.isActive, true);
      
      // 값 설정 후 완료
      controller.setValue('결과값');
      final result = await future;
      
      expect(result, '결과값');
    });

    test('showWithResult() 취소 시 null 반환', () async {
      final future = controller.showWithResult(InputType.keyboard);
      expect(controller.isActive, true);
      
      // 취소
      controller.hide();
      final result = await future;
      
      expect(result, null);
    });
  });
}