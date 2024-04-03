class Schedule {
  int id;
  String court;
  DateTime date;
  String name;

  Schedule({
    required this.id,
    required this.court,
    required this.date,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'court': court,
      'date': date.toIso8601String(),
      'name': name,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['id'] ?? 0,
      court: map['court'] ?? '',
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      name: map['name'] ?? '',
    );
  }
}
