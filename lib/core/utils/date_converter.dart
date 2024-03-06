import 'package:intl/intl.dart';

String formatDateTimeRange(DateTime startDateTime, DateTime endDateTime) {
  String formattedStartDate = DateFormat('MMM d, h:mm a').format(startDateTime);
  String formattedEndDate = DateFormat('h:mm a').format(endDateTime);

  return '$formattedStartDate - $formattedEndDate';
}
