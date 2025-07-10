class Dive {
  final String location;
  final DateTime date;
  final String diveOperator;
  final String boat;
  final String diveType;

  Dive({
    required this.location,
    required this.date,
    this.diveOperator = 'N/A',
    this.boat = 'N/A',
    this.diveType = 'Scuba',
  });
}
