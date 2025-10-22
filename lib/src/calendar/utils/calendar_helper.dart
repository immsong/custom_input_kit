/// 날짜 및 캘린더 관련 유틸리티 함수를 제공하는 헬퍼 클래스
///
/// 주요 기능:
/// - 월의 첫 요일 및 마지막 날짜 계산
/// - 월/요일 이름 변환
/// - DateTime ↔ String 변환
class CalendarHelper {
  /// 현재 날짜를 반환합니다.
  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  /// 특정 년도, 월의 시작 요일을 반환합니다.
  ///
  /// 반환값: 1(월요일) ~ 7(일요일)
  static int getFirstWeekday(int year, int month) {
    return DateTime(year, month, 1).weekday;
  }

  /// 특정 년도, 월의 마지막 날짜를 반환합니다.
  ///
  /// 윤년도 자동으로 계산됩니다.
  static int getLastDay(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// 특정 년도, 월의 시작 요일과 마지막 날짜를 반환합니다.
  ///
  /// 반환값: {firstWeekday: 1~7, lastDay: 28~31}
  static Map<String, int> getMonthInfo(int year, int month) {
    return {
      'firstWeekday': getFirstWeekday(year, month),
      'lastDay': getLastDay(year, month),
    };
  }

  /// 월 숫자를 영어 약어(3글자)로 변환합니다.
  ///
  /// 1 -> "JAN", 2 -> "FEB", ...
  static String getMonthNameShort(int month) {
    const monthNames = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    if (month < 1 || month > 12) {
      return 'N/A';
    }

    return monthNames[month - 1];
  }

  /// 요일 숫자를 영어 약어로 변환합니다.
  ///
  /// 1 -> "Mon", 2 -> "Tue", ..., 7 -> "Sun"
  static String getWeekdayName(int weekday) {
    const weekdayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    if (weekday < 1 || weekday > 7) {
      return 'N/A';
    }

    return weekdayNames[weekday - 1];
  }

  /// DateTime을 문자열로 변환합니다.
  ///
  /// 형식: yyyy-MM-dd
  static String dateTimeToString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 문자열을 DateTime으로 변환합니다.
  ///
  /// 형식: yyyy-MM-dd
  /// 파싱 실패 시 현재 날짜 반환
  static DateTime stringToDateTime(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return DateTime.now();
    }
  }
}
