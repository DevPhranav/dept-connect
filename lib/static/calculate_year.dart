class CalculateYear {
  String getYearText(String batchYearRange) {
    List<String> years = batchYearRange.split('-');
    if (years.length != 2) {
      return "Invalid year range";
    }

    int currentYear = DateTime
        .now()
        .year;
    int batchYear = int.tryParse(years[0]) ?? currentYear;
    int yearDifference = currentYear - batchYear;

    return yearDifference == 1
        ? "1st year"
        : yearDifference == 2
        ? "2nd year"
        : yearDifference == 3
        ? "3rd year"
        : "4th year";
  }
}