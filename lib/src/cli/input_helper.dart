import 'dart:io';
import 'package:autopark_cli/src/domain/validators/validators.dart';

class InputHelper {
  static String askString(String prompt, {bool required = true}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync() ?? '';
      if (!required) return input;
      if (isValidRequiredString(input)) return input.trim();
      print('Ошибка: поле не может быть пустым. Попробуйте снова.');
    }
  }

  static int askInt(String prompt, {bool positive = true}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync() ?? '';
      final int? value = int.tryParse(input);
      if (value != null && (!positive || isValidPositiveInt(value))) {
        return value;
      }
      print('Ошибка: введите целое число ${positive ? 'больше 0' : ''}.');
    }
  }

  static double askDouble(String prompt, {bool positive = true}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync() ?? '';
      final double? value = double.tryParse(input);
      if (value != null && (!positive || isValidPositiveDouble(value))) {
        return value;
      }
      print('Ошибка: введите число ${positive ? 'больше 0' : ''}.');
    }
  }

  static DateTime askDateTime(String prompt) {
    while (true) {
      stdout.write('$prompt (ГГГГ-ММ-ДД ЧЧ:ММ:СС): ');
      final input = stdin.readLineSync() ?? '';
      try {
        return DateTime.parse(input);
      } catch (_) {
        print('Ошибка: неверный формат даты/времени. Используйте ГГГГ-ММ-ДД ЧЧ:ММ:СС');
      }
    }
  }

  static int askIdForExistingEntity(String prompt, List<dynamic> entities) {
    if (entities.isEmpty) {
      print('Сначала необходимо создать хотя бы одну запись.');
      return -1;
    }
    print('Доступные ID: ${entities.map((e) => e.id).join(', ')}');
    while (true) {
      final id = askInt(prompt, positive: true);
      if (entities.any((e) => e.id == id)) return id;
      print('Ошибка: ID не найден. Попробуйте снова.');
    }
  }
}