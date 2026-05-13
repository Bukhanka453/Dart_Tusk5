class Vehicle {
  int? id;
  String regNumber;
  String brand;
  String model;
  int capacityKg;
  String status; // active, repair, retired

  Vehicle({
    this.id,
    required this.regNumber,
    required this.brand,
    required this.model,
    required this.capacityKg,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'reg_number': regNumber,
    'brand': brand,
    'model': model,
    'capacity_kg': capacityKg,
    'status': status,
  };

  factory Vehicle.fromMap(Map<String, dynamic> map) => Vehicle(
    id: map['id'],
    regNumber: map['reg_number'],
    brand: map['brand'],
    model: map['model'],
    capacityKg: map['capacity_kg'],
    status: map['status'],
  );

  @override
  String toString() => '[$id] $brand $model ($regNumber) | грузоподъёмность: ${capacityKg}кг | статус: $status';
}