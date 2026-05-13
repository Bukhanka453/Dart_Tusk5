import 'package:test/test.dart';
import 'package:autopark_cli/src/domain/validators/validators.dart';

void main() {
  test('Не пустая строка', () {
    expect(isValidRequiredString(' hello '), true);
    expect(isValidRequiredString(''), false);
    expect(isValidRequiredString('   '), false);
  });

  test('Положительное число', () {
    expect(isValidPositiveInt(5), true);
    expect(isValidPositiveInt(-1), false);
    expect(isValidPositiveInt(0), false);
  });
}