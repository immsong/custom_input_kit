/// 한글 자모 조합 및 분해를 처리하는 유틸리티
///
/// 키보드 입력(자모)을 완성형 한글로 조합하거나,
/// 완성형 한글을 다시 자모로 분해합니다.
class TextParser {
  // 초성
  static const firstList = [
    'ㄱ',
    'ㄲ',
    'ㄴ',
    'ㄷ',
    'ㄸ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅃ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅉ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ',
  ];

  // 중성
  static const secondList = [
    'ㅏ',
    'ㅐ',
    'ㅑ',
    'ㅒ',
    'ㅓ',
    'ㅔ',
    'ㅕ',
    'ㅖ',
    'ㅗ',
    'ㅘ',
    'ㅙ',
    'ㅚ',
    'ㅛ',
    'ㅜ',
    'ㅝ',
    'ㅞ',
    'ㅟ',
    'ㅠ',
    'ㅡ',
    'ㅢ',
    'ㅣ',
  ];

  // 종성
  static const thirdList = [
    '',
    'ㄱ',
    'ㄲ',
    'ㄳ',
    'ㄴ',
    'ㄵ',
    'ㄶ',
    'ㄷ',
    'ㄹ',
    'ㄺ',
    'ㄻ',
    'ㄼ',
    'ㄽ',
    'ㄾ',
    'ㄿ',
    'ㅀ',
    'ㅁ',
    'ㅂ',
    'ㅄ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ',
  ];

  // 겹받침 조합
  static const doubleVowelMap = {
    'ㄱ': {'ㅅ': 'ㄳ'},
    'ㄴ': {'ㅈ': 'ㄵ', 'ㅎ': 'ㄶ'},
    'ㄹ': {'ㄱ': 'ㄺ', 'ㅁ': 'ㄻ', 'ㅂ': 'ㄼ', 'ㅅ': 'ㄽ', 'ㅌ': 'ㄾ', 'ㅍ': 'ㄿ', 'ㅎ': 'ㅀ'},
    'ㅂ': {'ㅅ': 'ㅄ'},
  };

  // 복합 모음 조합
  static const complexVowelMap = {
    'ㅗ': {'ㅏ': 'ㅘ', 'ㅐ': 'ㅙ', 'ㅣ': 'ㅚ'},
    'ㅜ': {'ㅓ': 'ㅝ', 'ㅔ': 'ㅞ', 'ㅣ': 'ㅟ'},
    'ㅡ': {'ㅣ': 'ㅢ'},
  };

  /// 자음 여부를 확인합니다.
  static bool isConsonant(String char) {
    return firstList.contains(char);
  }

  /// 모음 여부를 확인합니다.
  static bool isVowel(String char) {
    return secondList.contains(char);
  }

  /// 초성, 중성, 종성을 조합하여 완성형 한글을 생성합니다.
  ///
  /// [first]: 초성 (예: 'ㄱ')
  /// [second]: 중성 (예: 'ㅏ')
  /// [third]: 종성 (선택사항)
  ///
  /// 반환: 조합된 한글 (예: '가', '각')
  static String? compose(String first, String second, [String? third]) {
    final firstIndex = firstList.indexOf(first);
    final secondIndex = secondList.indexOf(second);
    final thirdIndex = thirdList.indexOf(third ?? '');

    if (firstIndex == -1 || secondIndex == -1 || thirdIndex == -1) {
      return null;
    }

    /* 한글 유니코드 조합 공식
      초성 'ㄷ' → index 3
      중성 'ㅏ' → index 0
      종성 'ㄺ' → index 9

      유니코드 = 0xAC00 + (3 × 588) + (0 × 28) + 9
            = 44032 + 1764 + 0 + 9
            = 45805

      String.fromCharCode(45805) = '닭'
    */
    final unicode =
        0xAC00 + (firstIndex * 588) + (secondIndex * 28) + thirdIndex;

    return String.fromCharCode(unicode);
  }

  /// 자모 배열을 완성형 한글로 조합합니다.
  ///
  /// 키보드 입력처럼 순차적으로 입력된 자모를 완성형 한글로 변환합니다.
  /// 복합 모음, 겹받침 등을 자동으로 처리합니다.
  ///
  /// [chars]: 자모 배열 (예: ['ㅎ', 'ㅏ', 'ㄴ', 'ㄱ', 'ㅡ', 'ㄹ'])
  ///
  /// 반환: 조합된 문자열 (예: "한글")
  static String parse(List<String> chars) {
    if (chars.isEmpty) return '';

    List<String> result = [];
    int i = 0;

    while (i < chars.length) {
      final char = chars[i];

      // 한글이 아닌 경우 (영문, 숫자, 기호 등)
      if (!isConsonant(char) && !isVowel(char)) {
        result.add(char);
        i++;
        continue;
      }

      // 자음인 경우
      if (isConsonant(char)) {
        // 다음이 모음이면 조합 시작
        if (i + 1 < chars.length && isVowel(chars[i + 1])) {
          final first = char;
          String second = chars[i + 1];
          String? third;
          int charUsedCount = 2;

          // 복합 모음 확인 (ㅗ + ㅏ = ㅘ)
          if (i + 2 < chars.length && isVowel(chars[i + 2])) {
            final complexVowel = complexVowelMap[second]?[chars[i + 2]];
            if (complexVowel != null) {
              second = complexVowel;
              charUsedCount = 3;
            }
          }

          // 종성(받침) 확인
          if (i + charUsedCount < chars.length &&
              isConsonant(chars[i + charUsedCount])) {
            if (i + charUsedCount + 1 < chars.length &&
                isVowel(chars[i + charUsedCount + 1])) {
              // nothing
              // 다음에 모음이 오면 받침을 만들지 않고 새 글자로 진행
              // ㅎ + ㅗ + ㅎ + ㅗ 형태
            } else {
              third = chars[i + charUsedCount];
              charUsedCount++;

              // 겹받침 확인 (ㄹ + ㄱ = ㄺ)
              if (i + charUsedCount < chars.length &&
                  isConsonant(chars[i + charUsedCount])) {
                final doubleVowel =
                    doubleVowelMap[third]?[chars[i + charUsedCount]];
                if (doubleVowel != null) {
                  // 다음 글자가 만들어지는지 확인
                  // "달ㄱㅏ"인지 "닭ㅏ"인지 구분
                  if (i + charUsedCount + 1 < chars.length &&
                      isVowel(chars[i + charUsedCount + 1])) {
                    // 다음에 모음이 오면 겹받침 안 만들고 새 글자 시작
                    // "달" + "가" 형태
                  } else {
                    // 겹받침 적용
                    third = doubleVowel;
                    charUsedCount++;
                  }
                }
              }
            }
          }

          // 한글 조합
          final composed = compose(first, second, third);
          if (composed != null) {
            result.add(composed);
          }

          i += charUsedCount;
        } else {
          // 단독 자음
          result.add(char);
          i++;
        }
      } else {
        // 단독 모음
        result.add(char);
        i++;
      }
    }

    return result.join('');
  }

  /// 완성형 한글 여부를 확인합니다.
  ///
  /// [char]: 확인할 문자
  ///
  /// 반환: 완성형 한글이면 true ('가' ~ '힣')
  static bool isCompleteKorean(String char) {
    if (char.isEmpty) return false;
    final code = char.codeUnitAt(0);
    return code >= 0xAC00 && code <= 0xD7AF; // '가' ~ '힣'
  }

  /// 완성형 한글을 초성, 중성, 종성으로 분해합니다.
  ///
  /// [char]: 분해할 완성형 한글 (예: '한')
  ///
  /// 반환: (초성, 중성, 종성) 튜플 (예: ('ㅎ', 'ㅏ', 'ㄴ'))
  static (String, String, String?) decompose(String char) {
    final code = char.codeUnitAt(0) - 0xAC00;

    final firstIndex = code ~/ 588;
    final secondIndex = (code % 588) ~/ 28;
    final thirdIndex = code % 28;

    final first = firstList[firstIndex];
    final second = secondList[secondIndex];
    final third = thirdIndex == 0 ? null : thirdList[thirdIndex];

    return (first, second, third);
  }

  /// 겹받침을 기본 자음으로 분해합니다.
  ///
  /// [consonant]: 겹받침 (예: 'ㄺ')
  ///
  /// 반환: 분해된 자음 리스트 (예: ['ㄹ', 'ㄱ']) 또는 null
  static List<String>? splitDoubleConsonant(String consonant) {
    for (final entry in doubleVowelMap.entries) {
      for (final value in entry.value.entries) {
        if (value.value == consonant) {
          return [entry.key, value.key];
        }
      }
    }
    return null;
  }

  /// 복합 모음을 기본 모음으로 분해합니다.
  ///
  /// [vowel]: 복합 모음 (예: 'ㅘ')
  ///
  /// 반환: 분해된 모음 리스트 (예: ['ㅗ', 'ㅏ']) 또는 null
  static List<String>? splitComplexVowel(String vowel) {
    for (final entry in complexVowelMap.entries) {
      for (final value in entry.value.entries) {
        if (value.value == vowel) {
          return [entry.key, value.key];
        }
      }
    }
    return null;
  }

  /// 완성형 한글 문자열을 자모 배열로 분해합니다 (역변환).
  ///
  /// 키보드 편집 모드에서 사용됩니다.
  /// 완성형 한글을 자모로 분해하고, 복합 모음과 겹받침도 기본 자모로 분해합니다.
  ///
  /// [text]: 분해할 문자열 (예: "한글")
  ///
  /// 반환: 자모 배열 (예: ['ㅎ', 'ㅏ', 'ㄴ', 'ㄱ', 'ㅡ', 'ㄹ'])
  static List<String> toCharList(String text) {
    List<String> result = [];

    for (int i = 0; i < text.length; i++) {
      final char = text[i];

      // 완성형 한글인 경우 분해
      if (isCompleteKorean(char)) {
        final (first, second, third) = decompose(char);

        // 초성
        result.add(first);

        // 중성 (복합 모음 분해)
        final splitVowel = splitComplexVowel(second);
        if (splitVowel != null) {
          result.addAll(splitVowel);
        } else {
          result.add(second);
        }

        // 종성 (겹받침 분해)
        if (third != null) {
          final splitConsonant = splitDoubleConsonant(third);
          if (splitConsonant != null) {
            result.addAll(splitConsonant);
          } else {
            result.add(third);
          }
        }
      } else {
        // 한글이 아니면 그대로 추가
        result.add(char);
      }
    }

    return result;
  }
}
