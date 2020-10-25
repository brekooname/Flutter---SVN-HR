class ApplicationController {
  ApplicationController._();

  static String formatToHours(int number) {
    int hours = (number / 3600).round();
    int mintues = number % 3600;

    return hours.toString() + ":" + mintues.toString();
  }
}
