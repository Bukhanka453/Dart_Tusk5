import 'package:autopark_cli/src/domain/models/driver.dart';
import 'package:autopark_cli/src/data/database.dart';

class DriverRepository {
  Future<List<Driver>> getAll() async {
    final rows = DatabaseHelper.selectAllDrivers();
    return rows.map((row) => Driver.fromMap(row)).toList();
  }

  Future<Driver?> getById(int id) async {
    final row = DatabaseHelper.selectDriverById(id);
    return row != null ? Driver.fromMap(row) : null;
  }

  Future<void> create(Driver driver) async {
    await DatabaseHelper.insertDriver({
      'first_name': driver.firstName,
      'last_name': driver.lastName,
      'license_number': driver.licenseNumber,
      'hire_date': driver.hireDate.toIso8601String(),
      'phone': driver.phone,
    });
  }

  Future<void> update(Driver driver) async {
    await DatabaseHelper.updateDriver({
      'first_name': driver.firstName,
      'last_name': driver.lastName,
      'license_number': driver.licenseNumber,
      'hire_date': driver.hireDate.toIso8601String(),
      'phone': driver.phone,
    }, driver.id!);
  }

  Future<void> delete(int id) async {
    await DatabaseHelper.deleteDriver(id);
  }
}