import 'package:autopark_cli/src/domain/models/trip.dart';
import 'package:autopark_cli/src/data/database.dart';

class TripRepository {
  Future<List<Trip>> getAll() async {
    final rows = DatabaseHelper.selectAllTrips();
    return rows.map((row) => Trip.fromMap(row)).toList();
  }

  Future<Trip?> getById(int id) async {
    final row = DatabaseHelper.selectTripById(id);
    return row != null ? Trip.fromMap(row) : null;
  }

  Future<void> create(Trip trip) async {
    await DatabaseHelper.insertTrip({
      'vehicle_id': trip.vehicleId,
      'driver_id': trip.driverId,
      'route_id': trip.routeId,
      'departure_time': trip.departureTime.toIso8601String(),
      'arrival_time': trip.arrivalTime?.toIso8601String(),
      'cargo_description': trip.cargoDescription,
      'cargo_weight_kg': trip.cargoWeightKg,
    });
  }

  Future<void> update(Trip trip) async {
    await DatabaseHelper.updateTrip({
      'vehicle_id': trip.vehicleId,
      'driver_id': trip.driverId,
      'route_id': trip.routeId,
      'departure_time': trip.departureTime.toIso8601String(),
      'arrival_time': trip.arrivalTime?.toIso8601String(),
      'cargo_description': trip.cargoDescription,
      'cargo_weight_kg': trip.cargoWeightKg,
    }, trip.id!);
  }

  Future<void> delete(int id) async {
    await DatabaseHelper.deleteTrip(id);
  }
}