import 'package:autopark_cli/src/domain/models/maintenance.dart';
import 'package:autopark_cli/src/data/database.dart';

class MaintenanceRepository {
  Future<List<Maintenance>> getAll() async {
    final rows = DatabaseHelper.selectAllMaintenances();
    return rows.map((row) => Maintenance.fromMap(row)).toList();
  }

  Future<Maintenance?> getById(int id) async {
    final row = DatabaseHelper.selectMaintenanceById(id);
    return row != null ? Maintenance.fromMap(row) : null;
  }

  Future<void> create(Maintenance maintenance) async {
    await DatabaseHelper.insertMaintenance({
      'vehicle_id': maintenance.vehicleId,
      'date': maintenance.date.toIso8601String(),
      'type': maintenance.type,
      'cost': maintenance.cost,
      'next_due_km': maintenance.nextDueKm,
    });
  }

  Future<void> update(Maintenance maintenance) async {
    await DatabaseHelper.updateMaintenance({
      'vehicle_id': maintenance.vehicleId,
      'date': maintenance.date.toIso8601String(),
      'type': maintenance.type,
      'cost': maintenance.cost,
      'next_due_km': maintenance.nextDueKm,
    }, maintenance.id!);
  }

  Future<void> delete(int id) async {
    await DatabaseHelper.deleteMaintenance(id);
  }
}