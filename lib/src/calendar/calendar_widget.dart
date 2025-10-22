import 'package:flutter/material.dart';

import 'package:custom_input_kit/src/controller/custom_input_controller.dart';
import 'package:custom_input_kit/src/calendar/utils/calendar_helper.dart';

/// 날짜 선택을 위한 커스텀 캘린더 위젯
///
/// 년/월 네비게이션과 날짜 선택을 지원하는 캘린더입니다.
/// CustomInputController를 통해 제어됩니다.
class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  /// 선택된 년도
  int _year = 0;

  /// 선택된 월
  int _month = 0;

  /// 선택된 일
  int _selectedDay = 0;

  @override
  void initState() {
    super.initState();

    if (CustomInputController.instance.initialValue is DateTime) {
      DateTime initialValue =
          CustomInputController.instance.initialValue as DateTime;
      _year = initialValue.year;
      _month = initialValue.month;
      _selectedDay = initialValue.day;
    } else {
      _year = DateTime.now().year;
      _month = DateTime.now().month;
      _selectedDay = DateTime.now().day;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 년도 달 선택 영역
        Expanded(
          child: Container(
            color: CustomInputController.instance.isUseDarkTheme
                ? Colors.grey[800]
                : Colors.grey[200],
            child: Row(
              children: [
                const Spacer(flex: 3),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _month = _month - 1;
                          if (_month < 1) {
                            _month = 12;
                            _year = _year - 1;
                          }
                          _selectedDay = 1;
                        });
                      },
                      icon: Icon(Icons.arrow_left,
                          color: CustomInputController.instance.isUseDarkTheme
                              ? Colors.grey[200]
                              : Colors.grey[800]),
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    child: Text(
                      "$_year - ${_month.toString().padLeft(2, '0')} - ${_selectedDay.toString().padLeft(2, '0')}",
                      style: TextStyle(
                          color: CustomInputController.instance.isUseDarkTheme
                              ? Colors.grey[200]
                              : Colors.grey[800]),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _month = _month + 1;
                          if (_month > 12) {
                            _month = 1;
                            _year = _year + 1;
                          }
                          _selectedDay = 1;
                        });
                      },
                      icon: Icon(Icons.arrow_right,
                          color: CustomInputController.instance.isUseDarkTheme
                              ? Colors.grey[200]
                              : Colors.grey[800]),
                    ),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
        // 캘린더 영역
        Expanded(
          flex: 5,
          child: Container(
              color: CustomInputController.instance.isUseDarkTheme
                  ? Colors.grey[800]
                  : Colors.grey[200],
              child: _buildCalendar()),
        ),
      ],
    );
  }

  /// 캘린더 전체 레이아웃을 구성합니다.
  Widget _buildCalendar() {
    return Column(children: [
      Expanded(child: _buildCalendarHeader()),
      Expanded(flex: 10, child: _buildCalendarBody()),
      Expanded(flex: 2, child: _buildFooter()),
    ]);
  }

  /// 캘린더 헤더(요일)를 반환합니다.
  Widget _buildCalendarHeader() {
    return Row(children: [
      const Spacer(flex: 7),
      for (var i = 1; i <= 7; i++) ...[
        Expanded(
            child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.scaleDown,
          child: Text(
            CalendarHelper.getWeekdayName(i),
            style: TextStyle(
              color: CustomInputController.instance.isUseDarkTheme
                  ? Colors.grey[200]
                  : Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
        if (i != 7) SizedBox(width: 10),
      ],
      const Spacer(flex: 7),
    ]);
  }

  /// 캘린더 본체(날짜 그리드)를 반환합니다.
  Widget _buildCalendarBody() {
    final monthInfo = CalendarHelper.getMonthInfo(_year, _month);
    final firstWeekday = monthInfo['firstWeekday']!;
    final lastDay = monthInfo['lastDay']!;
    int startDay = (1 - firstWeekday);

    return Column(
      children: [
        for (var i = 1; i <= 29; i = i + 7) ...[
          Expanded(
            child: Row(
              children: [
                const Spacer(flex: 7),
                for (var j = i; j < i + 7; j++) ...[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if ((j + startDay < 1) || (j + startDay > lastDay)) {
                          return;
                        }

                        setState(() {
                          _selectedDay = j + startDay;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: j + startDay == _selectedDay
                              ? CustomInputController.instance.isUseDarkTheme
                                  ? Colors.grey[200]
                                  : Colors.grey[800]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: FittedBox(
                          alignment: Alignment.center,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            (j + startDay < 1) || (j + startDay > lastDay)
                                ? ''
                                : (j + startDay).toString(),
                            style: TextStyle(
                              color: j + startDay == _selectedDay
                                  ? (CustomInputController
                                          .instance.isUseDarkTheme
                                      ? Colors.grey[800]
                                      : Colors.grey[200])
                                  : (j % 7 == 0)
                                      ? Colors.red // 일요일
                                      : (j % 7 == 6)
                                          ? Colors.blue // 토요일
                                          : CustomInputController
                                                  .instance.isUseDarkTheme
                                              ? Colors.grey[200]
                                              : Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (j % 7 != 0) SizedBox(width: 10),
                ],
                const Spacer(flex: 7),
              ],
            ),
          ),
        ]
      ],
    );
  }

  /// 캘린더 하단 버튼 영역을 반환합니다.
  Widget _buildFooter() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(children: [
          const Spacer(flex: 2),
          Expanded(
            child: GestureDetector(
              onTap: () {
                CustomInputController.instance.setIsUseDarkTheme(
                  !CustomInputController.instance.isUseDarkTheme,
                );
              },
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  '◗',
                  style: TextStyle(
                    color: CustomInputController.instance.isUseDarkTheme
                        ? Colors.grey[200]
                        : Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                CustomInputController.instance.setValue(DateTime(
                  _year,
                  _month,
                  _selectedDay,
                ));
                CustomInputController.instance.hide();
              },
              child: FittedBox(
                alignment: Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: Text(
                  'Select',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
        ]));
  }
}
