import 'package:intl/intl.dart';

class DateToDisplayFormat{

  String formattedDate(DateTime date, DateTime editedDate) {

    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;

    String formattedDate;

    if (isToday) {
      formattedDate = DateFormat('h:mm a').format(date);
    } else {
      formattedDate = DateFormat('MMM d, h:mm a').format(date);
    }

    // Ignore seconds for comparison
    final adjustedDate = DateTime(date.year, date.month, date.day, date.hour, date.minute);
    final adjustedEditedDate = DateTime(editedDate.year, editedDate.month, editedDate.day, editedDate.hour, editedDate.minute);

    if (adjustedDate != adjustedEditedDate) {
      final durationDifference = adjustedEditedDate.difference(adjustedDate).abs();
      final editedTime = DateFormat('h:mm a').format(editedDate);

      if (durationDifference.inMinutes >= 2) {
        if (date.year == editedDate.year && date.month == editedDate.month && date.day == editedDate.day) {
          formattedDate += ' (edited $editedTime)';
        } else {
          formattedDate = '${DateFormat('MMM d').format(date)}, (edited $editedTime)';
        }
      }
    }

    return formattedDate;
  }
}