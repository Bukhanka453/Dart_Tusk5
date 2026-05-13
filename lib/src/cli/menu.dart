import 'package:autopark_cli/src/data/repositories/vehicle_repo.dart';
import 'package:autopark_cli/src/data/repositories/driver_repo.dart';
import 'package:autopark_cli/src/data/repositories/route_repo.dart';
import 'package:autopark_cli/src/data/repositories/trip_repo.dart';
import 'package:autopark_cli/src/data/repositories/maintenance_repo.dart';
import 'package:autopark_cli/src/cli/input_helper.dart';
import 'package:autopark_cli/src/domain/models/vehicle.dart';
import 'package:autopark_cli/src/domain/models/driver.dart';
import 'package:autopark_cli/src/domain/models/route.dart';
import 'package:autopark_cli/src/domain/models/trip.dart';
import 'package:autopark_cli/src/domain/models/maintenance.dart';

class Menu {
  final VehicleRepository _vehicleRepo = VehicleRepository();
  final DriverRepository _driverRepo = DriverRepository();
  final RouteRepository _routeRepo = RouteRepository();
  final TripRepository _tripRepo = TripRepository();
  final MaintenanceRepository _maintenanceRepo = MaintenanceRepository();

  Future<void> run() async {
    while (true) {
      print('\n=== АВТОПАРК ЛОГИСТИКА ===');
      print('1. Транспортные средства');
      print('2. Водители');
      print('3. Маршруты');
      print('4. Рейсы');
      print('5. Техобслуживание');
      print('6. ПОКАЗАТЬ ВСЁ ИЗ БД');
      print('0. Выход');
      final choice = InputHelper.askInt('Выберите пункт', positive: false);

      switch (choice) {
        case 1: await _vehicleMenu(); break;
        case 2: await _driverMenu(); break;
        case 3: await _routeMenu(); break;
        case 4: await _tripMenu(); break;
        case 5: await _maintenanceMenu(); break;
        case 6: await _showAllData(); break;
        case 0: return;
        default: print('Неверный пункт');
      }
    }
  }

  Future<void> _vehicleMenu() async {
    while (true) {
      print('\n--- ТРАНСПОРТНЫЕ СРЕДСТВА ---');
      print('1. Список');
      print('2. Добавить');
      print('3. Редактировать');
      print('4. Удалить');
      print('0. Назад');
      final choice = InputHelper.askInt('Выберите', positive: false);
      if (choice == 0) return;
      switch (choice) {
        case 1:
          final list = await _vehicleRepo.getAll();
          for (var v in list) print(v);
          break;
        case 2:
          final reg = InputHelper.askString('Госномер');
          final brand = InputHelper.askString('Марка');
          final model = InputHelper.askString('Модель');
          final cap = InputHelper.askInt('Грузоподъёмность (кг)', positive: true);
          final status = InputHelper.askString('Статус (active/repair/retired)');
          await _vehicleRepo.create(Vehicle(
            regNumber: reg,
            brand: brand,
            model: model,
            capacityKg: cap,
            status: status,
          ));
          print('✅ Добавлено');
          break;
        case 3:
          final list = await _vehicleRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID авто для редактирования', list);
          if (id == -1) break;
          final old = await _vehicleRepo.getById(id);
          if (old == null) break;
          final reg = InputHelper.askString('Госномер [${old.regNumber}]', required: false);
          final brand = InputHelper.askString('Марка [${old.brand}]', required: false);
          final model = InputHelper.askString('Модель [${old.model}]', required: false);
          final cap = InputHelper.askInt('Грузоподъёмность (кг) [${old.capacityKg}]', positive: true);
          final status = InputHelper.askString('Статус [${old.status}]', required: false);
          await _vehicleRepo.update(Vehicle(
            id: id,
            regNumber: reg.isNotEmpty ? reg : old.regNumber,
            brand: brand.isNotEmpty ? brand : old.brand,
            model: model.isNotEmpty ? model : old.model,
            capacityKg: cap > 0 ? cap : old.capacityKg,
            status: status.isNotEmpty ? status : old.status,
          ));
          print('✅ Обновлено');
          break;
        case 4:
          final list = await _vehicleRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID авто для удаления', list);
          if (id == -1) break;
          await _vehicleRepo.delete(id);
          print('✅ Удалено');
          break;
      }
    }
  }

  Future<void> _driverMenu() async {
    while (true) {
      print('\n--- ВОДИТЕЛИ ---');
      print('1. Список');
      print('2. Добавить');
      print('3. Редактировать');
      print('4. Удалить');
      print('0. Назад');
      final choice = InputHelper.askInt('Выберите', positive: false);
      if (choice == 0) return;
      switch (choice) {
        case 1:
          final list = await _driverRepo.getAll();
          for (var d in list) print(d);
          break;
        case 2:
          final first = InputHelper.askString('Имя');
          final last = InputHelper.askString('Фамилия');
          final license = InputHelper.askString('Номер прав');
          final hire = InputHelper.askDateTime('Дата найма');
          final phone = InputHelper.askString('Телефон');
          await _driverRepo.create(Driver(
            firstName: first,
            lastName: last,
            licenseNumber: license,
            hireDate: hire,
            phone: phone,
          ));
          print('✅ Добавлено');
          break;
        case 3:
          final list = await _driverRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID водителя для редактирования', list);
          if (id == -1) break;
          final old = await _driverRepo.getById(id);
          if (old == null) break;
          final first = InputHelper.askString('Имя [${old.firstName}]', required: false);
          final last = InputHelper.askString('Фамилия [${old.lastName}]', required: false);
          final license = InputHelper.askString('Номер прав [${old.licenseNumber}]', required: false);
          final hire = InputHelper.askDateTime('Дата найма');
          final phone = InputHelper.askString('Телефон [${old.phone}]', required: false);
          await _driverRepo.update(Driver(
            id: id,
            firstName: first.isNotEmpty ? first : old.firstName,
            lastName: last.isNotEmpty ? last : old.lastName,
            licenseNumber: license.isNotEmpty ? license : old.licenseNumber,
            hireDate: hire,
            phone: phone.isNotEmpty ? phone : old.phone,
          ));
          print('✅ Обновлено');
          break;
        case 4:
          final list = await _driverRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID водителя для удаления', list);
          if (id == -1) break;
          await _driverRepo.delete(id);
          print('✅ Удалено');
          break;
      }
    }
  }

  Future<void> _routeMenu() async {
    while (true) {
      print('\n--- МАРШРУТЫ ---');
      print('1. Список');
      print('2. Добавить');
      print('3. Редактировать');
      print('4. Удалить');
      print('0. Назад');
      final choice = InputHelper.askInt('Выберите', positive: false);
      if (choice == 0) return;
      switch (choice) {
        case 1:
          final list = await _routeRepo.getAll();
          for (var r in list) print(r);
          break;
        case 2:
          final start = InputHelper.askString('Откуда');
          final end = InputHelper.askString('Куда');
          final dist = InputHelper.askDouble('Расстояние (км)', positive: true);
          final est = InputHelper.askInt('Время (мин)', positive: true);
          await _routeRepo.create(Route(
            startPoint: start,
            endPoint: end,
            distanceKm: dist,
            estimatedTimeMin: est,
          ));
          print('✅ Добавлено');
          break;
        case 3:
          final list = await _routeRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID маршрута для редактирования', list);
          if (id == -1) break;
          final old = await _routeRepo.getById(id);
          if (old == null) break;
          final start = InputHelper.askString('Откуда [${old.startPoint}]', required: false);
          final end = InputHelper.askString('Куда [${old.endPoint}]', required: false);
          final dist = InputHelper.askDouble('Расстояние (км) [${old.distanceKm}]', positive: true);
          final est = InputHelper.askInt('Время (мин) [${old.estimatedTimeMin}]', positive: true);
          await _routeRepo.update(Route(
            id: id,
            startPoint: start.isNotEmpty ? start : old.startPoint,
            endPoint: end.isNotEmpty ? end : old.endPoint,
            distanceKm: dist > 0 ? dist : old.distanceKm,
            estimatedTimeMin: est > 0 ? est : old.estimatedTimeMin,
          ));
          print('✅ Обновлено');
          break;
        case 4:
          final list = await _routeRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID маршрута для удаления', list);
          if (id == -1) break;
          await _routeRepo.delete(id);
          print('✅ Удалено');
          break;
      }
    }
  }

  Future<void> _tripMenu() async {
    while (true) {
      print('\n--- РЕЙСЫ ---');
      print('1. Список');
      print('2. Добавить');
      print('3. Редактировать');
      print('4. Удалить');
      print('0. Назад');
      final choice = InputHelper.askInt('Выберите', positive: false);
      if (choice == 0) return;
      switch (choice) {
        case 1:
          final list = await _tripRepo.getAll();
          for (var t in list) print(t);
          break;
        case 2:
          final vehicles = await _vehicleRepo.getAll();
          if (vehicles.isEmpty) { print('Сначала добавьте транспорт'); break; }
          final vId = InputHelper.askIdForExistingEntity('ID авто', vehicles);
          if (vId == -1) break;
          final drivers = await _driverRepo.getAll();
          if (drivers.isEmpty) { print('Сначала добавьте водителя'); break; }
          final dId = InputHelper.askIdForExistingEntity('ID водителя', drivers);
          if (dId == -1) break;
          final routes = await _routeRepo.getAll();
          if (routes.isEmpty) { print('Сначала добавьте маршрут'); break; }
          final rId = InputHelper.askIdForExistingEntity('ID маршрута', routes);
          if (rId == -1) break;
          final dep = InputHelper.askDateTime('Время отправления');
          final arrStr = InputHelper.askString('Время прибытия (оставьте пустым, если неизвестно)', required: false);
          final arrival = arrStr.isNotEmpty ? DateTime.tryParse(arrStr) : null;
          final cargoDesc = InputHelper.askString('Описание груза');
          final weight = InputHelper.askDouble('Вес груза (кг)', positive: true);
          await _tripRepo.create(Trip(
            vehicleId: vId,
            driverId: dId,
            routeId: rId,
            departureTime: dep,
            arrivalTime: arrival,
            cargoDescription: cargoDesc,
            cargoWeightKg: weight,
          ));
          print('✅ Добавлено');
          break;
        case 3:
          final list = await _tripRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID рейса для редактирования', list);
          if (id == -1) break;
          final old = await _tripRepo.getById(id);
          if (old == null) break;
          final vehicles = await _vehicleRepo.getAll();
          final vId = InputHelper.askIdForExistingEntity('ID авто [${old.vehicleId}]', vehicles);
          final drivers = await _driverRepo.getAll();
          final dId = InputHelper.askIdForExistingEntity('ID водителя [${old.driverId}]', drivers);
          final routes = await _routeRepo.getAll();
          final rId = InputHelper.askIdForExistingEntity('ID маршрута [${old.routeId}]', routes);
          final dep = InputHelper.askDateTime('Время отправления');
          final arrStr = InputHelper.askString('Время прибытия', required: false);
          final arrival = arrStr.isNotEmpty ? DateTime.tryParse(arrStr) : old.arrivalTime;
          final cargoDesc = InputHelper.askString('Описание груза [${old.cargoDescription}]', required: false);
          final weight = InputHelper.askDouble('Вес груза (кг) [${old.cargoWeightKg}]', positive: true);
          await _tripRepo.update(Trip(
            id: id,
            vehicleId: vId,
            driverId: dId,
            routeId: rId,
            departureTime: dep,
            arrivalTime: arrival,
            cargoDescription: cargoDesc.isNotEmpty ? cargoDesc : old.cargoDescription,
            cargoWeightKg: weight > 0 ? weight : old.cargoWeightKg,
          ));
          print('✅ Обновлено');
          break;
        case 4:
          final list = await _tripRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID рейса для удаления', list);
          if (id == -1) break;
          await _tripRepo.delete(id);
          print('✅ Удалено');
          break;
      }
    }
  }

  Future<void> _maintenanceMenu() async {
    while (true) {
      print('\n--- ТЕХОБСЛУЖИВАНИЕ ---');
      print('1. Список');
      print('2. Добавить');
      print('3. Редактировать');
      print('4. Удалить');
      print('0. Назад');
      final choice = InputHelper.askInt('Выберите', positive: false);
      if (choice == 0) return;
      switch (choice) {
        case 1:
          final list = await _maintenanceRepo.getAll();
          for (var m in list) print(m);
          break;
        case 2:
          final vehicles = await _vehicleRepo.getAll();
          if (vehicles.isEmpty) { print('Сначала добавьте транспорт'); break; }
          final vId = InputHelper.askIdForExistingEntity('ID авто', vehicles);
          if (vId == -1) break;
          final date = InputHelper.askDateTime('Дата ТО');
          final type = InputHelper.askString('Тип ТО');
          final cost = InputHelper.askDouble('Стоимость', positive: true);
          final nextDue = InputHelper.askInt('Пробег до следующего ТО (опционально, 0 если нет)', positive: false);
          await _maintenanceRepo.create(Maintenance(
            vehicleId: vId,
            date: date,
            type: type,
            cost: cost,
            nextDueKm: nextDue > 0 ? nextDue : null,
          ));
          print('✅ Добавлено');
          break;
        case 3:
          final list = await _maintenanceRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID ТО для редактирования', list);
          if (id == -1) break;
          final old = await _maintenanceRepo.getById(id);
          if (old == null) break;
          final vehicles = await _vehicleRepo.getAll();
          final vId = InputHelper.askIdForExistingEntity('ID авто [${old.vehicleId}]', vehicles);
          final date = InputHelper.askDateTime('Дата ТО');
          final type = InputHelper.askString('Тип ТО [${old.type}]', required: false);
          final cost = InputHelper.askDouble('Стоимость [${old.cost}]', positive: true);
          final nextDue = InputHelper.askInt('Пробег до след. ТО [${old.nextDueKm ?? "нет"}]', positive: false);
          await _maintenanceRepo.update(Maintenance(
            id: id,
            vehicleId: vId,
            date: date,
            type: type.isNotEmpty ? type : old.type,
            cost: cost > 0 ? cost : old.cost,
            nextDueKm: nextDue > 0 ? nextDue : old.nextDueKm,
          ));
          print('✅ Обновлено');
          break;
        case 4:
          final list = await _maintenanceRepo.getAll();
          if (list.isEmpty) { print('Список пуст'); break; }
          final id = InputHelper.askIdForExistingEntity('ID ТО для удаления', list);
          if (id == -1) break;
          await _maintenanceRepo.delete(id);
          print('✅ Удалено');
          break;
      }
    }
  }

  Future<void> _showAllData() async {
    print('\n========== ПОЛНЫЙ ДАМП БАЗЫ ДАННЫХ ==========');
    print('\n--- Транспортные средства ---');
    final vehicles = await _vehicleRepo.getAll();
    for (var v in vehicles) print(v);
    print('\n--- Водители ---');
    final drivers = await _driverRepo.getAll();
    for (var d in drivers) print(d);
    print('\n--- Маршруты ---');
    final routes = await _routeRepo.getAll();
    for (var r in routes) print(r);
    print('\n--- Рейсы ---');
    final trips = await _tripRepo.getAll();
    for (var t in trips) print(t);
    print('\n--- Техобслуживание ---');
    final maintenances = await _maintenanceRepo.getAll();
    for (var m in maintenances) print(m);
    print('============================================');
  }
}