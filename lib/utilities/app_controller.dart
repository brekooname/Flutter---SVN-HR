class ApplicationController {
  ApplicationController._();

  static String formatToHours(int number) {
    int hours = (number / 3600).floor();
    int extra = number % 3600;
    int minutes = (extra / 60).floor();
    int seconds = minutes % 60;

    return hours.toString() + ":" + minutes.toString();
  }

  static formatTimetoNum(int hours, int minutes, int seconds) {
    num fiveSecondFormat = hours * 60 * 60 + minutes * 60 + seconds;
    return fiveSecondFormat;
  }

  static int getHours(int number) {
    int hours = (number / 3600).floor();
    return hours;
  }

  static int getMinutes(int number) {
    int extra = number % 3600;
    int minutes = (extra / 60).floor();
    return minutes;
  }
}
