import 'package:calender_range_picker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime currentDate;
  final DateTime? selectRangeStart;
  final DateTime? selectRangeEnd;

  /// Arrow left to navigate calendar to previous month
  final Function()? onArrowLeft;

  /// Arrow right to navigate calendar to next month
  final Function()? onArrowRight;

  /// Color of start and end date
  final Color? markerColor;

  /// Color of range between start and end date
  final Color? rangeColor;

  /// Color of days of the week
  final Color? weekDaysColor;

  /// Selected day of the month
  final Function(DateTime)? onTap;

  const CustomCalendar({
    super.key,
    required this.currentDate,
    this.selectRangeStart,
    this.selectRangeEnd,
    this.onArrowLeft,
    this.onArrowRight,
    this.markerColor,
    this.rangeColor,
    this.weekDaysColor,
    this.onTap,
  });

  // Week day that First day of the Month fall, e.g Monday == 1
  int _firstDayOfMonthWeekday(DateTime? date) {
    return DateTime(date!.year, date.month, 1).weekday;
  }

  // Index to start painting days of the month from 1 - ..
  int _startIndex(DateTime? date) {
    return (_firstDayOfMonthWeekday(currentDate) + 6) % 7;
  }

  // Total calendar items (including empty spaces in start)
  int _calenderItemsLength(DateTime? date) {
    int emptyDays = _startIndex(date);

    return emptyDays + DateTime(date!.year, date.month + 1, 0).day;
  }

  // Check if a date falls between two dates
  bool _isDateWithinRange(DateTime date, DateTime startDate, DateTime endDate) {
    return date.isAfter(startDate.subtract(const Duration(days: 1))) &&
        date.isBefore(endDate);
  }

  // Compare the year, month, day components
  bool _isDatesEqual(DateTime? date1, DateTime date2) {
    return date1?.year == date2.year &&
        date1?.month == date2.month &&
        date1?.day == date2.day;
  }

  // Add Background Colors/Text Colors to date items
  Color? _colorDate({
    required DateTime? start,
    required DateTime? end,
    required DateTime current,
    required Color? color1,
    required Color? color2,
  }) {
    if (start != null &&
        end != null &&
        (!_isDatesEqual(start, current) && !_isDatesEqual(end, current)) &&
        _isDateWithinRange(current, start, end)) {
      return color2;
    } else if (!_isDatesEqual(start, current) && !_isDatesEqual(end, current)) {
      return null;
    } else if (_isDatesEqual(start, current)) {
      return color1;
    } else if (_isDatesEqual(end, current)) {
      return color1;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onArrowLeft,
                icon: SvgIcon(
                  svgIcon: SvgAssets.circleArrowLeft,
                  color: markerColor ?? primaryColor,
                ),
              ),
              sizedBox10,
              Expanded(
                child: TextWidget(
                  DateFormat('MMMM yyyy').format(currentDate),
                  textAlign: TextAlign.center,
                  weight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              sizedBox10,
              IconButton(
                onPressed: onArrowRight,
                icon: SvgIcon(
                  svgIcon: SvgAssets.circleArrowRight,
                  color: markerColor ?? primaryColor,
                ),
              ),
            ],
          ),
          sizedBox15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              return Center(
                child: TextWidget(
                  TimeUtil.calendarWeeks[index],
                  weight: FontWeight.bold,
                  color: weekDaysColor,
                ),
              );
            }),
          ),
          GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              height: 40,
              crossAxisCount: 7,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _calenderItemsLength(currentDate),
            itemBuilder: (BuildContext context, int index) {
              int startIndex = _startIndex(currentDate);

              int day = index - startIndex + 1;
              DateTime currentDay =
                  DateTime(currentDate.year, currentDate.month, day);

              if (day <= 0) {
                return Container();
              }

              Color? bgColor = _colorDate(
                start: selectRangeStart,
                end: selectRangeEnd,
                current: currentDay,
                color1: markerColor ?? primaryColor,
                color2: rangeColor ??
                    markerColor?.withOpacity(0.1) ??
                    primaryColor.withOpacity(0.1),
              );

              Color? textColor = _colorDate(
                start: selectRangeStart,
                end: selectRangeEnd,
                current: currentDay,
                color1: AppColors.white,
                color2: markerColor ?? primaryColor,
              );

              return InkWell(
                onTap: () {
                  onTap!(currentDay);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: _radius(selectRangeStart, currentDay),
                      bottomLeft: _radius(selectRangeStart, currentDay),
                      topRight: _radius(selectRangeEnd, currentDay),
                      bottomRight: _radius(selectRangeEnd, currentDay),
                    ),
                  ),
                  child: Center(
                    child: TextWidget(
                      '$day',
                      textAlign: TextAlign.center,
                      weight: textColor == null ? null : FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Border radius for marked item
  Radius _radius(DateTime? first, DateTime current) {
    return _isDatesEqual(first, current)
        ? const Radius.circular(7)
        : Radius.zero;
  }
}
