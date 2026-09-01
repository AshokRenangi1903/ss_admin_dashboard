String formatDateTime(String value) {
  final dateTime = DateTime.parse(value).toLocal();

  return "${dateTime.day.toString().padLeft(2, '0')} "
      "${_monthName(dateTime.month)} "
      "${dateTime.year}, "
      "${_formatTime(dateTime)}";
}

String _monthName(int month) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  return months[month - 1];
}

String _formatTime(DateTime dateTime) {
  final hour = dateTime.hour;
  final minute = dateTime.minute;

  final period = hour >= 12 ? "PM" : "AM";
  final displayHour = hour % 12 == 0 ? 12 : hour % 12;

  return "$displayHour:${minute.toString().padLeft(2, '0')} $period";
}