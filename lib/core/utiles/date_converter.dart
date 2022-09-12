import 'package:dartz/dartz.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../error/failures.dart';

/// Convert a String into a Date Time
///
/// Or vise vers ca
class DateConverter {
 static Either<Failure, DateTime> eitherStringToDateTime(String strDate) {
    try {
      final DateTime dateTime = DateTime.parse(strDate);
      final int year = dateTime.year;
      final int month = dateTime.month;
      final int day = dateTime.day;
      // final String date = '$year-$month-$day';
      final DateTime date = DateTime(year, month, day);
      return Right(date);
    } on FormatException {
      return Left(InvalidDateFailure());
    }
  }

static  DateTime stringToDateTime(String strDate) {
    try {
      final DateTime dateTime = DateTime.parse(strDate);
      final int year = dateTime.year;
      final int month = dateTime.month;
      final int day = dateTime.day;
      final int hour = dateTime.hour;
      final int minute = dateTime.minute;
      final int second = dateTime.second;
      // final String date = '$year-$month-$day';
      final DateTime date = DateTime(year, month, day, hour, minute, second);
      return date;
    } on FormatException {
      return DateTime.now();
    }
  }

  /// Convert DateTime to string
  ///
  /// Exp: ven. 21 juin
  static String dateTimeToIsoString(DateTime dateTime) {
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('EEE dd MMM', 'en');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  /// Convert DateTime to string time
  ///
  /// Exp: 02h45
  static String timeToIsoString(DateTime dateTime) {
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('HH\'h\'mm', 'en');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  /// Convert DateTime to string for date with time
  ///
  /// ven. 21 juin 02h45
  static String fullDateToIsoString(DateTime dateTime) {
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('EEE dd MMM HH\'h\'mm', 'en');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  /// Convert string date to string without time
  ///
  /// Exp: ven. 21 juin
static  String isoToStringDate(String strDate) {
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('EEE dd MMM', 'en');
    final DateTime dateTime = DateTime.parse(strDate);
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  /// Convert string date to string time
  ///
  /// Exp: 02:45
  static String isoToStringTime(String strDate) {
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('HH:mm', 'en');
    final DateTime dateTime = DateTime.parse(strDate);
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  /// Convert DateTime to date
  ///
  /// Exp: 21/06/2004
  static String dateToSlashString(DateTime date) {
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('dd/MM/y');
    final String formatted = formatter.format(date);
    return formatted;
  }

}

class InvalidDateFailure extends Failure {}
