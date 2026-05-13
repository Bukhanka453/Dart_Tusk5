import 'package:autopark_cli/src/domain/models/route.dart';
import 'package:autopark_cli/src/data/database.dart';

class RouteRepository {
  Future<List<Route>> getAll() async {
    final rows = DatabaseHelper.selectAllRoutes();
    return rows.map((row) => Route.fromMap(row)).toList();
  }

  Future<Route?> getById(int id) async {
    final row = DatabaseHelper.selectRouteById(id);
    return row != null ? Route.fromMap(row) : null;
  }

  Future<void> create(Route route) async {
    await DatabaseHelper.insertRoute({
      'start_point': route.startPoint,
      'end_point': route.endPoint,
      'distance_km': route.distanceKm,
      'estimated_time_min': route.estimatedTimeMin,
    });
  }

  Future<void> update(Route route) async {
    await DatabaseHelper.updateRoute({
      'start_point': route.startPoint,
      'end_point': route.endPoint,
      'distance_km': route.distanceKm,
      'estimated_time_min': route.estimatedTimeMin,
    }, route.id!);
  }

  Future<void> delete(int id) async {
    await DatabaseHelper.deleteRoute(id);
  }
}