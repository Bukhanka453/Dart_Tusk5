import 'package:test/test.dart';
import 'package:autopark_cli/src/data/database.dart';
import 'package:autopark_cli/src/data/repositories/vehicle_repo.dart';
import 'package:autopark_cli/src/domain/models/vehicle.dart';

void main() {
  // Очищаем таблицу vehicles перед каждым тестом
  setUp(() {
    DatabaseHelper.db.execute('DELETE FROM vehicles');
  });

  tearDownAll(() {
    DatabaseHelper.close();
  });

  test('VehicleRepository: create и getAll работают', () async {
    final repo = VehicleRepository();
    final vehicle = Vehicle(
      regNumber: 'TEST123',
      brand: 'TestBrand',
      model: 'TestModel',
      capacityKg: 1000,
      status: 'active',
    );
    await repo.create(vehicle);
    final all = await repo.getAll();
    expect(all.length, 1);
    expect(all.first.regNumber, 'TEST123');
  });

  test('VehicleRepository: getById возвращает правильную запись', () async {
    final repo = VehicleRepository();
    final vehicle = Vehicle(
      regNumber: 'UNIQ456',
      brand: 'Unique',
      model: 'Car',
      capacityKg: 2000,
      status: 'active',
    );
    await repo.create(vehicle);
    final created = (await repo.getAll()).first;
    final fetched = await repo.getById(created.id!);
    expect(fetched!.regNumber, 'UNIQ456');
  });

  test('VehicleRepository: update изменяет данные', () async {
    final repo = VehicleRepository();
    final vehicle = Vehicle(
      regNumber: 'OLD123',
      brand: 'Old',
      model: 'Car',
      capacityKg: 1500,
      status: 'active',
    );
    await repo.create(vehicle);
    final created = (await repo.getAll()).first;
    created.brand = 'UpdatedBrand';
    await repo.update(created);
    final updated = await repo.getById(created.id!);
    expect(updated!.brand, 'UpdatedBrand');
  });

  test('VehicleRepository: delete удаляет запись', () async {
    final repo = VehicleRepository();
    final vehicle = Vehicle(
      regNumber: 'DEL123',
      brand: 'DeleteMe',
      model: 'Car',
      capacityKg: 500,
      status: 'retired',
    );
    await repo.create(vehicle);
    final created = (await repo.getAll()).first;
    await repo.delete(created.id!);
    final all = await repo.getAll();
    expect(all.isEmpty, true);
  });
}