class TimeUtil {
  static const List<String> calendarWeeks = [
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN"
  ];

  static List<String> weekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime getTime60MinutesAgo(DateTime currentTime) {
    // Subtract 60 minutes from the current time
    return currentTime.subtract(const Duration(minutes: 60));
  }

  static DateTime getDate7DaysAgo(DateTime currentDate) {
    // Subtract 7 days from the current date
    return currentDate.subtract(const Duration(days: 7));
  }

  static DateTime getDateXMonthsAgo(DateTime currentDate, int months) {
    // Subtract the specified number of months from the current date
    int currentYear = currentDate.year;
    int currentMonth = currentDate.month;
    int newMonth = currentMonth - months;
    int newYear = currentYear;

    // Adjust for negative months
    while (newMonth <= 0) {
      newMonth += 12;
      newYear--;
    }

    return DateTime(newYear, newMonth, currentDate.day);
  }

  static DateTime get24HoursAgo(DateTime currentDate) {
    return currentDate.subtract(const Duration(hours: 24));
  }

  static DateTime getDateXMonthsNext(DateTime currentDate, int months) {
    // Subtract the specified number of months from the current date
    int currentYear = currentDate.year;
    int currentMonth = currentDate.month;
    int newMonth = currentMonth + months;
    int newYear = currentYear;

    // Adjust for negative months
    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }

    return DateTime(newYear, newMonth, currentDate.day);
  }

  // Compare the year and month components
  static bool isMonthEqual(DateTime? date1, DateTime date2) {
    return date1?.year == date2.year && date1?.month == date2.month;
  }

  // Compare the year, month, and day components
  static bool isDatesEqual(DateTime? date1, DateTime date2) {
    return date1?.year == date2.year &&
        date1?.month == date2.month &&
        date1?.day == date2.day;
  }
}
