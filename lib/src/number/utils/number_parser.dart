/// 숫자 입력 문자열을 정제하고 유효성을 검증하는 파서입니다.
class NumberParser {
  // 입력된 문자 리스트를 숫자로서 유효한 문자들만 남겨 정제합니다.
  // 반환값은 정제된 문자 리스트(문자 단위)입니다.
  static List<String> parse(List<String> numbers) {
    if (numbers.isEmpty) return [];

    // 유효하지 않은 조합 필터링 및 정규화 수행
    final validNumbers = _validateNumbers(numbers);
    return validNumbers;
  }

  /// 숫자 유효성 검증 및 정규화 규칙:
  /// - 소수점(.)은 최대 1개만 허용. 맨 앞에서 시작하면 '0.'로 보정
  /// - 선행 0은 제거(예: '01' -> '1'), 단 '0', '0.xxx'는 허용
  /// - 숫자(0-9)와 소수점 외 문자는 무시
  /// - 결과가 비어있거나 소수점만 남는 경우 '0'으로 대체
  static List<String> _validateNumbers(List<String> numbers) {
    final result = <String>[];
    bool hasDecimalPoint = false;
    bool hasLeadingZero = false;

    for (int i = 0; i < numbers.length; i++) {
      final char = numbers[i];

      // 소수점 처리
      if (char == '.') {
        // 이미 소수점이 있으면 무시
        if (hasDecimalPoint) {
          continue;
        } else if (i == 0) {
          // 맨 앞의 '.'은 '0.'로 보정
          hasDecimalPoint = true;
          result.add('0');
          result.add('.');
          continue;
        }

        hasDecimalPoint = true;
        result.add(char);
        continue;
      }

      // 숫자가 아니면 무시
      if (!_isDigit(char)) {
        continue;
      }

      // '0' 처리
      if (char == '0') {
        // 첫 글자가 0이면 일단 허용(뒤에 숫자가 오면 선행 0 제거)
        if (i == 0) {
          hasLeadingZero = true;
          result.add(char);
          continue;
        }

        // '00', '01' 등: 선행 0 제거 후 현재 값 반영
        if (hasLeadingZero && result.length == 1 && result[0] == '0') {
          result.clear();
          result.add(char);
          hasLeadingZero = false;
          continue;
        }

        // 그 외 자리의 0은 그대로 허용(예: 100, 10.0)
        result.add(char);
        continue;
      }

      // 1-9 처리: '01', '02' 등의 선행 0 제거
      if (hasLeadingZero && result.length == 1 && result[0] == '0') {
        result.clear();
      }

      hasLeadingZero = false;
      result.add(char);
    }

    // 결과가 비었거나 '.'만 남은 경우 '0' 반환
    if (result.isEmpty || (result.length == 1 && result[0] == '.')) {
      return ['0'];
    }

    return result;
  }

  /// 단일 문자가 0-9 범위의 숫자인지 여부
  static bool _isDigit(String char) {
    return char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
  }
}