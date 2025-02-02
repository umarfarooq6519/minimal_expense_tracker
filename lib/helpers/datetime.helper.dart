// convert datetime object to string
String convertDateTimeToString(DateTime datetime) {
  // year in format -> yyyy
  String year = datetime.year.toString();

  // month in format -> mm
  String month = datetime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // date in format -> dd
  String day = datetime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
