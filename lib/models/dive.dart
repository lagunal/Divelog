class Dive {
  final String location;
  final DateTime date;
  final String diveOperator;
  final String boat;
  final List<String> diveType;

  Dive(
      {required this.location,
      required this.date,
      this.diveOperator = 'N/A',
      this.boat = 'N/A',
      List<String>? diveType})
      : diveType = diveType ?? ['Scuba'];
}
