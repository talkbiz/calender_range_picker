import 'package:calender_range_picker/src/constants/constants.dart';
import 'package:calender_range_picker/src/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomRangeCalendar extends StatefulWidget {
  final Function(DateTime? start, DateTime? end, String? timeRangeInText)?
      onApply;

  /// Color of start and end date
  final Color? markerColor;

  /// Color of range between start and end date
  final Color? rangeColor;

  /// Color of Apply button
  final Color? buttonColor;

  /// Color of days of the week
  final Color? weekDaysColor;

  /// Background color of calender
  final Color? backgroundColor;

  /// Show Time with Date e.g [01/Mar/2024 12:00 AM] or [01/Mar/2024]
  final bool showTime;

  /// Custom Date range e.g [01/Mar/2024 12:00 AM - 05/Mar/2024 12:00 AM]
  final DateFormat? customDateRangeFormatter;

  const CustomRangeCalendar({
    super.key,
    this.onApply,
    this.markerColor,
    this.rangeColor,
    this.buttonColor,
    this.weekDaysColor,
    this.backgroundColor,
    this.showTime = true,
    this.customDateRangeFormatter,
  });

  @override
  State<CustomRangeCalendar> createState() => _CustomRangeCalendarState();
}

class _CustomRangeCalendarState extends State<CustomRangeCalendar> {
  // Current time
  final DateTime _currentDate = DateTime.now();

  // First calender
  DateTime? _firstCalender;
  // Second calender
  DateTime? _secondCalender;

  // Date starting point
  DateTime? selectRangeStart;
  // Date ending point
  DateTime? selectRangeEnd;

  // Custom range
  String timeRangeInText = "Custom";

  @override
  void initState() {
    // Add past month
    _firstCalender = TimeUtil.getDateXMonthsAgo(_currentDate, 1);
    // Add current month
    _secondCalender = _currentDate;
    super.initState();
  }

  /// Get date in this format [01/Mar/2024 12:00 AM]
  String _getDateString(DateTime? date) {
    return date != null
        ? widget.customDateRangeFormatter?.format(date) ??
            DateFormat("dd/MMM/yyyy${widget.showTime ? ' h:mm a' : ''}")
                .format(date)
        : '';
  }

  void _onDaySelected(DateTime selectedDay) {
    // This is triggered when a day is clicked
    // on the calendar month

    if (selectRangeStart == null) {
      // StartDate is null, add a newly selected date
      selectRangeStart = selectedDay;
    } else if (selectedDay.isAfter(selectRangeStart!) &&
        selectRangeEnd == null) {
      // StartDate has data,
      // check if the current StartDate data is day(s) after the newly StartDate data.
      // And also if the EndDate is null
      selectRangeEnd = selectedDay;
    } else {
      // If the condition above is not met,
      // the user probably click a previous days from the StartDate.
      // So we make it the new StartDate
      selectRangeStart = selectedDay;
      selectRangeEnd = null;
    }
    timeRangeInText = "Custom";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        width: 730,
        child: Card(
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      CustomCalendar(
                        currentDate: _firstCalender!,
                        selectRangeStart: selectRangeStart,
                        selectRangeEnd: selectRangeEnd,
                        onArrowLeft: () {
                          // Get one year ago from today
                          DateTime oneYearAgo =
                              _currentDate.subtract(const Duration(days: 365));

                          // Get previous month from today at [00:00 AM]
                          DateTime prevMonth =
                              TimeUtil.getDateXMonthsAgo(_firstCalender!, 1);

                          // You can't click previous month past 1 year from today
                          if (!prevMonth.isAfter(oneYearAgo)) return;

                          // Add previous month to the first calender
                          _firstCalender = prevMonth;
                          setState(() {});
                        },
                        onArrowRight: () {
                          // Get next month from today at [00:00 AM]
                          DateTime nextMonth =
                              TimeUtil.getDateXMonthsNext(_firstCalender!, 1);

                          // You can't click next month from first calender
                          // if it is the same month with the second calendar
                          if (TimeUtil.isMonthEqual(
                              nextMonth, _secondCalender!)) {
                            return;
                          }

                          // Add next month to the first calender
                          _firstCalender = nextMonth;
                          setState(() {});
                        },
                        onTap: _onDaySelected,
                        markerColor: widget.markerColor,
                        rangeColor: widget.rangeColor,
                        weekDaysColor: widget.weekDaysColor,
                      ),
                      sizedBoxHor15,
                      CustomCalendar(
                        currentDate: _secondCalender!,
                        selectRangeStart: selectRangeStart,
                        selectRangeEnd: selectRangeEnd,
                        onArrowLeft: () {
                          // Get previous month from today at [00:00 AM]
                          DateTime prevMonth =
                              TimeUtil.getDateXMonthsAgo(_secondCalender!, 1);

                          // You can't click previous month from second calender
                          // if it is the same month with the first calendar
                          if (TimeUtil.isMonthEqual(
                              prevMonth, _firstCalender!)) {
                            return;
                          }

                          // Add previous month to the second calender
                          _secondCalender = prevMonth;
                          setState(() {});
                        },
                        onArrowRight: () {
                          // Get next month from today at [00:00 AM]
                          DateTime nextMonth =
                              TimeUtil.getDateXMonthsNext(_secondCalender!, 1);

                          // You can't click next month past this current month
                          if (nextMonth.isAfter(_currentDate)) return;

                          // Add next month to the second calender
                          _secondCalender = nextMonth;
                          setState(() {});
                        },
                        onTap: _onDaySelected,
                        markerColor: widget.markerColor,
                        rangeColor: widget.rangeColor,
                        weekDaysColor: widget.weekDaysColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 320,
                    width: 20,
                    child: VerticalDivider(),
                  ),
                  _CustomRange(
                    currentDate: _currentDate,
                    timeRangeInText: timeRangeInText,
                    rangeColor: widget.rangeColor,
                    markerColor: widget.markerColor,
                    dateRange: (start, end, time) {
                      selectRangeStart = start;
                      selectRangeEnd = end;
                      timeRangeInText = time;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        TextWidget(selectRangeStart == null
                            ? ''
                            : _getDateString(selectRangeStart)),
                        TextWidget(selectRangeEnd == null
                            ? ''
                            : "  -  ${_getDateString(selectRangeEnd)}"),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(80, 45),
                      ),
                      onPressed:
                          (selectRangeStart != null && selectRangeEnd != null)
                              ? () {
                                  widget.onApply!(selectRangeStart,
                                      selectRangeEnd, timeRangeInText);
                                }
                              : null,
                      child: TextWidget(
                        "Apply",
                        color:
                            (selectRangeStart != null && selectRangeEnd != null)
                                ? widget.buttonColor
                                : widget.buttonColor?.withOpacity(0.1),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomRange extends StatelessWidget {
  final DateTime currentDate;
  final String timeRangeInText;
  final Color? rangeColor;
  final Color? markerColor;

  final Function(DateTime, DateTime, String) dateRange;

  const _CustomRange({
    required this.currentDate,
    required this.timeRangeInText,
    required this.dateRange,
    this.rangeColor,
    this.markerColor,
  });

  Widget _widget(
    Function()? onTap,
    String text,
    BuildContext context,
  ) {
    Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: timeRangeInText == text
            ? rangeColor ??
                markerColor?.withOpacity(0.1) ??
                primaryColor.withOpacity(0.1)
            : null,
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: TextWidget(
          text,
          color: timeRangeInText == text ? markerColor ?? primaryColor : null,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _widget(
            () {
              dateRange(
                TimeUtil.getTime60MinutesAgo(currentDate),
                currentDate,
                "Last 60 minutes",
              );
            },
            "Last 60 minutes",
            context,
          ),
          _widget(
            () {
              dateRange(
                TimeUtil.get24HoursAgo(currentDate),
                currentDate,
                "Last 24 hours",
              );
            },
            "Last 24 hours",
            context,
          ),
          _widget(
            () {
              dateRange(
                TimeUtil.getDate7DaysAgo(currentDate),
                currentDate,
                "Last 7 days",
              );
            },
            "Last 7 days",
            context,
          ),
          _widget(
            () {
              dateRange(
                TimeUtil.getDateXMonthsAgo(currentDate, 1),
                currentDate,
                "Last 30 days",
              );
            },
            "Last 30 days",
            context,
          ),
          _widget(
            () {
              dateRange(
                TimeUtil.getDateXMonthsAgo(currentDate, 3),
                currentDate,
                "Last 90 days",
              );
            },
            "Last 90 days",
            context,
          ),
        ],
      ),
    );
  }
}
