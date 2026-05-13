class Trip {
  int? id;
  int vehicleId;
  int driverId;
  int routeId;
  DateTime departureTime;
  DateTime? arrivalTime;
  String cargoDescription;
  double cargoWeightKg;

  Trip({
    this.id,
    required this.vehicleId,
    required this.driverId,
    required this.routeId,
    required this.departureTime,
    this.arrivalTime,
    required this.cargoDescription,
    required this.cargoWeightKg,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'vehicle_id': vehicleId,
    'driver_id': driverId,
    'route_id': routeId,
    'departure_time': departureTime.toIso8601String(),
    'arrival_time': arrivalTime?.toIso8601String(),
    'cargo_description': cargoDescription,
    'cargo_weight_kg': cargoWeightKg,
  };

  factory Trip.fromMap(Map<String, dynamic> map) => Trip(
    id: map['id'],
    vehicleId: map['vehicle_id'],
    driverId: map['driver_id'],
    routeId: map['route_id'],
    departureTime: DateTime.parse(map['departure_time']),
    arrivalTime: map['arrival_time'] != null ? DateTime.parse(map['arrival_time']) : null,
    cargoDescription: map['cargo_description'],
    cargoWeightKg: map['cargo_weight_kg'],
  );

  @override
  String toString() => '[$id] Рейс водитель:$driverId авто:$vehicleId маршрут:$routeId | отпр:${departureTime.toLocal()} | груз:$cargoDescription (${cargoWeightKg}кг)';
}