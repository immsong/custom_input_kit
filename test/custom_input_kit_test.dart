import 'package:flutter_test/flutter_test.dart';
import 'package:custom_input_kit/src/keyboard/utils/text_parser.dart';
import 'package:custom_input_kit/src/number/utils/number_parser.dart';
import 'package:custom_input_kit/src/calendar/utils/calendar_helper.dart';
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

  group('NumberParser - 숫자 유효성 검증', () {
    test('일반 숫자 입력', () {
      expect(NumberParser.parse(['1', '2', '3']), ['1', '2', '3']);
      expect(NumberParser.parse(['9', '9', '9']), ['9', '9', '9']);
    });

    test('소수점 입력', () {
      expect(NumberParser.parse(['1', '.', '5']), ['1', '.', '5']);
      expect(NumberParser.parse(['0', '.', '5']), ['0', '.', '5']);
    });

    test('소수점 중복 방지', () {
      expect(
          NumberParser.parse(['1', '.', '2', '.', '3']), ['1', '.', '2', '3']);
      expect(NumberParser.parse(['.', '.', '5']), ['0', '.', '5']);
    });

    test('맨 앞 소수점 보정', () {
      expect(NumberParser.parse(['.', '5']), ['0', '.', '5']);
      expect(NumberParser.parse(['.', '9', '9']), ['0', '.', '9', '9']);
    });

    test('선행 0 제거', () {
      expect(NumberParser.parse(['0', '1']), ['1']);
      expect(NumberParser.parse(['0', '5']), ['5']);
    });

    test('0.xx 형태는 허용', () {
      expect(NumberParser.parse(['0', '.', '5']), ['0', '.', '5']);
      expect(NumberParser.parse(['0', '.', '0', '1']), ['0', '.', '0', '1']);
    });

    test('단독 0 허용', () {
      expect(NumberParser.parse(['0']), ['0']);
    });

    test('빈 입력', () {
      expect(NumberParser.parse([]), []);
    });

    test('숫자가 아닌 문자 무시', () {
      expect(NumberParser.parse(['1', 'a', '2']), ['1', '2']);
      expect(NumberParser.parse(['x', 'y', 'z']), ['0']);
    });

    test('소수점만 있는 경우', () {
      expect(NumberParser.parse(['.']), ['0', '.']);
    });
  });

  group('CalendarHelper - 날짜 계산', () {
    test('첫 요일 계산', () {
      // 2024년 1월 1일은 월요일
      expect(CalendarHelper.getFirstWeekday(2024, 1), 1);
      // 2024년 2월 1일은 목요일
      expect(CalendarHelper.getFirstWeekday(2024, 2), 4);
    });

    test('마지막 날짜 계산', () {
      expect(CalendarHelper.getLastDay(2024, 1), 31); // 1월
      expect(CalendarHelper.getLastDay(2024, 2), 29); // 2월 (윤년)
      expect(CalendarHelper.getLastDay(2023, 2), 28); // 2월 (평년)
      expect(CalendarHelper.getLastDay(2024, 4), 30); // 4월
    });

    test('월 정보 반환', () {
      final info = CalendarHelper.getMonthInfo(2024, 1);
      expect(info['firstWeekday'], 1);
      expect(info['lastDay'], 31);
    });

    test('월 이름 변환', () {
      expect(CalendarHelper.getMonthNameShort(1), 'JAN');
      expect(CalendarHelper.getMonthNameShort(6), 'JUN');
      expect(CalendarHelper.getMonthNameShort(12), 'DEC');
    });

    test('잘못된 월 입력', () {
      expect(CalendarHelper.getMonthNameShort(0), 'N/A');
      expect(CalendarHelper.getMonthNameShort(13), 'N/A');
    });

    test('요일 이름 변환', () {
      expect(CalendarHelper.getWeekdayName(1), 'Mon');
      expect(CalendarHelper.getWeekdayName(6), 'Sat');
      expect(CalendarHelper.getWeekdayName(7), 'Sun');
    });

    test('잘못된 요일 입력', () {
      expect(CalendarHelper.getWeekdayName(0), 'N/A');
      expect(CalendarHelper.getWeekdayName(8), 'N/A');
    });

    test('DateTime to String 변환', () {
      final date = DateTime(2024, 1, 5);
      expect(CalendarHelper.dateTimeToString(date), '2024-01-05');

      final date2 = DateTime(2024, 12, 31);
      expect(CalendarHelper.dateTimeToString(date2), '2024-12-31');
    });

    test('String to DateTime 변환', () {
      final date = CalendarHelper.stringToDateTime('2024-01-05');
      expect(date.year, 2024);
      expect(date.month, 1);
      expect(date.day, 5);
    });

    test('잘못된 문자열 파싱 시 현재 날짜 반환', () {
      final result = CalendarHelper.stringToDateTime('invalid');
      expect(result, isA<DateTime>());
      // 현재 날짜가 반환되므로 DateTime 타입만 확인
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

    test('show()에 initialValue 전달', () {
      controller.show(InputType.keyboard, initialValue: '테스트');
      expect(controller.isActive, true);
      expect(controller.initialValue, '테스트');
    });

    test('다양한 InputType 지원', () {
      controller.show(InputType.keyboard);
      expect(controller.type, InputType.keyboard);

      controller.show(InputType.integer);
      expect(controller.type, InputType.integer);

      controller.show(InputType.float);
      expect(controller.type, InputType.float);

      controller.show(InputType.calendar);
      expect(controller.type, InputType.calendar);
    });

    test('DateTime을 initialValue로 전달', () {
      final date = DateTime(2024, 1, 5);
      controller.show(InputType.calendar, initialValue: date);
      expect(controller.initialValue, date);
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
