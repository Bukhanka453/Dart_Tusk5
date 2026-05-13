import 'package:test/test.dart';
import 'package:autopark_cli/src/domain/models/vehicle.dart';

void main() {
  test('Vehicle toMap / fromMap', () {
    final original = Vehicle(
      id: 1,
      regNumber: 'A123BC',
      brand: 'Volvo',
      model: 'FH',
      capacityKg: 20000,
      status: 'active',
    );
    final map = original.toMap();
    final restored = Vehicle.fromMap(map);
    expect(restored.id, original.id);
    expect(restored.regNumber, original.regNumber);
  });
}