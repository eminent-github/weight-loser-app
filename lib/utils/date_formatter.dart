import 'package:intl/intl.dart';

String formatDate(String dateString) {
  // Parse the input string to a DateTime object
  final inputDate = DateTime.parse(dateString);

  // Create a DateFormat to format the date as "M/d/yyyy"
  final formatter = DateFormat('M/d/yyyy');

  // Format the DateTime object as a string in the desired format
  final formattedDate = formatter.format(inputDate);

  return formattedDate;
}