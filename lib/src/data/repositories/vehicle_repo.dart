import 'package:autopark_cli/src/domain/models/vehicle.dart';
import 'package:autopark_cli/src/data/database.dart';

class VehicleRepository {
  Future<List<Vehicle>> getAll() async {
    final rows = DatabaseHelper.selectAllVehicles();
    return rows.map((row) => Vehicle.fromMap(row)).toList();
  }

  Future<Vehicle?> getById(int id) async {
    final row = DatabaseHelper.selectVehicleById(id);
    return row != null ? Vehicle.fromMap(row) : null;
  }

  Future<void> create(Vehicle vehicle) async {
    await DatabaseHelper.insertVehicle({
      'reg_number': vehicle.regNumber,
      'brand': vehicle.brand,
      'model': vehicle.model,
      'capacity_kg': vehicle.capacityKg,
      'status': vehicle.status,
    });
  }

  Future<void> update(Vehicle vehicle) async {
    await DatabaseHelper.updateVehicle({
      'reg_number': vehicle.regNumber,
      'brand': vehicle.brand,
      'model': vehicle.model,
      'capacity_kg': vehicle.capacityKg,
      'status': vehicle.status,
    }, vehicle.id!);
  }

  Future<void> delete(int id) async {
    await DatabaseHelper.deleteVehicle(id);
  }
}