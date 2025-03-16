import 'package:intl/intl.dart';
import 'package:medimate/src/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static AppUtils? _instance;

  AppUtils();

  static AppUtils getInstance() {
    _instance ??= AppUtils();
    return _instance!;
  }

  static String dateAsMonth(DateTime date) {
    return DateFormat.MMM().format(date);
  }

  static String dateAsDisplayString(DateTime date) {
    return DateFormat("d MMM, yyyy").format(date);
  }

  static String dateAsFullDisplayString(DateTime date) {
    return DateFormat("EEEE, d MMMM yyyy").format(date);
  }

  static String dateAsDateMonthDisplayString(DateTime date) {
    return DateFormat("EEEE d MMM").format(date);
  }

  static String dateAsCelebrationDisplayString(DateTime date) {
    return DateFormat("d MMMM").format(date);
  }

  static String dateAsObituaryDisplayString(DateTime date) {
    return DateFormat("d MMMM, yyyy").format(date);
  }

  static String dateAsPrayerQueryString(DateTime date) {
    DateTime dateTime =
        DateTime(date.month == 12 ? 2025 : 2026, date.month, date.day);
    print(DateFormat("yyyy-MM-dd").format(dateTime));
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  static String displayStringFromDateString(String dateString) {
    return dateAsCelebrationDisplayString(dateFromIndianString(dateString));
  }

  static String displayObituaryStringFromDateString(String dateString) {
    try {
      return dateAsObituaryDisplayString(dateFromIndianString(dateString));
    } catch (e) {
      return 'N.A';
    }
  }

  static String displayFullStringFromDateString(String dateString) {
    return dateAsDateMonthDisplayString(dateFromIndianString(dateString));
  }

  static DateTime dateFromString(String dateAsString) {
    return DateTime.parse(dateAsString.replaceAll("/", ""));
  }

  static String dateStringUpdate(String dateAsString) {
    return dateAsString.replaceAll("/", "-");
  }

  static String dateAsOccassionDisplayString(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  /// Expected Format dd/MM/YYYY
  static DateTime dateFromIndianString(String dateAsString) {
    List<String> date = dateAsString.split("/");
    date[0] = addLeadingZerosToDate(date[0]);
    date[1] = addLeadingZerosToDate(date[1]);
    return DateTime.parse(date[2] + date[1] + date[0]);
  }

  static String addLeadingZerosToDate(String val) {
    return val.trim().length == 1 ? (val = '0$val') : val;
  }

  static DateTime startOfWeek(DateTime dt, int startOfWeek) {
    final int diff = (7 + (dt.day - startOfWeek)) % 7;
    return dt.add(Duration(days: -1 * diff));
  }

  static DateTime getPrevSunday(DateTime dateTime) {
    final int weekDay = dateTime.weekday;
    final int offsetToSunday = weekDay;
    return prevDayBy(dateTime, offsetToSunday);
  }

  static DateTime getNextSunday(DateTime dateTime) {
    final int weekDay = dateTime.weekday;
    int offsetToSunday = 7 - weekDay;
    if (offsetToSunday <= 1) {
      offsetToSunday +=
          7; // go for next Sunday - if curr date is Sat or Sunday.
    }
    print('offset: $offsetToSunday');

    return nextDayBy(dateTime, offsetToSunday);
  }

  static DateTime nextDay(DateTime initialDate) {
    return nextDayBy(initialDate, 1);
  }

  static DateTime nextDayBy(DateTime initialDate, int offset) {
    final DateTime currDateTime = initialDate;
    return DateTime(
        currDateTime.year, currDateTime.month, currDateTime.day + offset);
  }

  static DateTime prevDayBy(DateTime initialDate, int offset) {
    final DateTime currDateTime = initialDate;
    return DateTime(
        currDateTime.year, currDateTime.month, currDateTime.day - offset);
  }

  static String getReadingString(int number) {
    switch (number) {
      case 1:
        return 'First Reading';
      case 2:
        return 'Second Reading';
      case 3:
        return 'Third Reading';
      case 49:
        return 'Psalms';
      case 4:
      case 9:
      case 99:
        return 'Gospel';
      default:
        return 'Reading';
    }
  }

  static String getCurrentLiturgyShortSeasonText(int seasonCode) {
    switch (seasonCode) {
      case liturgical_season_of_annunciation:
        return annunciation;
      case liturgical_season_of_apostles:
        return apostles;
      case liturgical_season_of_dedication:
        return dedication;
      case liturgical_season_of_elias:
        return elias;
      case liturgical_season_of_epiphany:
        return epiphany;
      case liturgical_season_of_lent:
        return lent;
      case liturgical_season_of_resurrection:
        return ressurection;
      case liturgical_season_of_summer:
        return summer;
      case liturgical_season_of_moses:
        return moses;
      default:
        return "";
    }
  }

  static String getWeekInWords(String week) {
    String day;
    if (week.endsWith("1") && !week.endsWith("11")) {
      day = "${week}st";
    } else if (week.endsWith("2") && !week.endsWith("12")) {
      day = "${week}nd";
    } else if (week.endsWith("3") && !week.endsWith("13")) {
      day = "${week}rd";
    } else {
      day = "${week}th";
    }
    return day;
  }

  // Helpful in removal of Extra OR or ; readings
  static String removeExtraReadings(String sReading, String key) {
    if (sReading.contains(key)) {
      sReading = sReading.substring(0, sReading.indexOf(key));
    }
    return sReading;
  }

  static bool isSunday(DateTime dateTime) {
    return dateTime.weekday == 7;
  }

  static bool isNotSunday(DateTime dateTime) {
    return !isSunday(dateTime);
  }

  static bool isSameDate(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  static String getCommonBookName(String bookName) {
    switch (bookName) {
      case '1Pet':
        bookName = '1Pt';
        break;
      case '2Pet':
        bookName = '2Pt';
        break;
      case 'Phil':
        bookName = 'Phili';
        break;
      case 'Deut':
        bookName = 'Dt';
        break;
      case '1Thess':
        bookName = '1Thes';
        break;
      case '2Thess':
        bookName = '2Thes';
        break;
      case 'Song':
        bookName = 'Sos';
        break;
      case '1Kings':
      case '1Kig':
        bookName = '1Kgs';
        break;
      case '2Kings':
        bookName = '2Kgs';
        break;
      case 'Gn':
        bookName = 'Gen';
        break;
      case 'Eze':
        bookName = 'Ezek';
        break;
      case 'Cr':
        bookName = '1Cor';
        break;
      case '1Timothy':
        bookName = '1Tim';
        break;
      case '2Timothy':
        bookName = '2Tim';
        break;
      case 'Hosea':
        bookName = 'Hos';
        break;
      case 'Zeph':
        bookName = 'Zep';
        break;
      case 'Pro':
        bookName = 'Prov';
        break;
      case 'Eccl':
        bookName = 'Ecc';
        break;
      case 'Ester':
        bookName = 'Est';
        break;
      case 'Jgs':
        bookName = 'Judg';
        break;
      case 'Ezr':
        bookName = 'Ezra';
        break;
      case 'Phlm':
        bookName = 'Philem';
        break;
      case 'Jdt':
        bookName = 'Jud';
        break;
      case 'Am':
        bookName = 'Amos';
        break;
      case '2Macc':
        bookName = '2Mac';
        break;
      case '1Macc':
        bookName = '1Mac';
        break;
      case 'Tb':
        bookName = 'Tob';
        break;
      case 'Sirach':
        bookName = 'Sir';
        break;
      case 'James':
        bookName = 'Jas';
        break;
      case 'Ru':
      case 'Rut':
        bookName = 'Ruth';
        break;
      case '2Chor':
        bookName = '2Cr';
        break;
    }
    return bookName;
  }

  static String getDigitsOnly(String readMode) {
    String digitOnly = "";
    for (int i = 0; i < readMode.length; i++) {
      String c = readMode[i];

      try {
        int.parse(c);
        digitOnly += c;
      } catch (e) {}
    }
    return digitOnly.toString();
  }

  ///
  /// @param reading
  static Future<double?> getSharedPrefDoubleValue(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    double? val = sp.getDouble(key);
    return (null != val) ? double.parse(val.toStringAsFixed(1)) : null;
    return null;
  }

  static Future<bool?> setSharedPrefDoubleValue(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setDouble(key, value);
    return null;
  }

  Future<void> setSharedPrefBoolValue(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getSharedPrefBoolValue(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
    return null;
  }

  Future<int?> getSharedPrefIntValue(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
    return null;
  }

  Future<bool?> setSharedPrefIntValue(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setInt(key, value);
    return null;
  }
}
