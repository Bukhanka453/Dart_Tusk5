class Maintenance {
  int? id;
  int vehicleId;
  DateTime date;
  String type;
  double cost;
  int? nextDueKm;

  Maintenance({
    this.id,
    required this.vehicleId,
    required this.date,
    required this.type,
    required this.cost,
    this.nextDueKm,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'vehicle_id': vehicleId,
    'date': date.toIso8601String(),
    'type': type,
    'cost': cost,
    'next_due_km': nextDueKm,
  };

  factory Maintenance.fromMap(Map<String, dynamic> map) => Maintenance(
    id: map['id'],
    vehicleId: map['vehicle_id'],
    date: DateTime.parse(map['date']),
    type: map['type'],
    cost: map['cost'],
    nextDueKm: map['next_due_km'],
  );

  @override
  String toString() => '[$id] ТО для авто $vehicleId | ${date.toLocal()} | $type | стоимость: $cost руб. | next due: ${nextDueKm ?? "—"}';
}