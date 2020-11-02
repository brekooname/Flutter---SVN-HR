class ApplicationController {
  ApplicationController._();

  static String formatToHours(int number) {
    int hours = (number / 3600).round();
    int mintues = number % 3600;

    return hours.toString() + ":" + mintues.toString();
  }

  static formatTimetoNum(int hours, int minutes, int seconds) {
    num fiveSecondFormat = hours * 60 * 60 + minutes * 60 + seconds;
    return fiveSecondFormat;
  }
}
