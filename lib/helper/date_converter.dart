import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('MMMM dd, yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateTime(String dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalMonthDateTime(String dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(isoStringToLocalDate(dateTime));
  }


  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }


  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateToDateAndTimeAm(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }


  static String isoStringToLocalString(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(dateTime).toLocal());
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('MMMM dd, yyyy  ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }



  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }



  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }


  static String _timeFormatter() {
    return 'HH:mm a';
    // return Get.find<SplashController>().configModel.timeformat == '24' ? 'HH:mm' : 'hh:mm a';
  }


  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('${_timeFormatter()} | d-MMM-yyyy ').format(dateTime.toLocal());
  }
  static String localToIsoString(DateTime dateTime) {
    return DateFormat('d MMMM, yyyy ').format(dateTime.toLocal());
  }

  static String estimatedDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy ${_timeFormatter()}').format(dateTime);
  }

}
