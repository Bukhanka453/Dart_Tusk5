import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  static Database? _db;

  static Database get db {
    if (_db == null) {
      _db = sqlite3.open('autopark.db');
      _createTables();
    }
    return _db!;
  }

  static void _createTables() {
    final db = _db!;
    db.execute('''
      CREATE TABLE IF NOT EXISTS vehicles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        reg_number TEXT UNIQUE NOT NULL,
        brand TEXT NOT NULL,
        model TEXT NOT NULL,
        capacity_kg INTEGER NOT NULL,
        status TEXT NOT NULL
      );
      CREATE TABLE IF NOT EXISTS drivers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        license_number TEXT UNIQUE NOT NULL,
        hire_date TEXT NOT NULL,
        phone TEXT NOT NULL
      );
      CREATE TABLE IF NOT EXISTS routes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        start_point TEXT NOT NULL,
        end_point TEXT NOT NULL,
        distance_km REAL NOT NULL,
        estimated_time_min INTEGER NOT NULL
      );
      CREATE TABLE IF NOT EXISTS trips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vehicle_id INTEGER NOT NULL,
        driver_id INTEGER NOT NULL,
        route_id INTEGER NOT NULL,
        departure_time TEXT NOT NULL,
        arrival_time TEXT,
        cargo_description TEXT,
        cargo_weight_kg REAL NOT NULL,
        FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE RESTRICT,
        FOREIGN KEY (driver_id) REFERENCES drivers(id) ON DELETE RESTRICT,
        FOREIGN KEY (route_id) REFERENCES routes(id) ON DELETE RESTRICT
      );
      CREATE TABLE IF NOT EXISTS maintenances (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vehicle_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        type TEXT NOT NULL,
        cost REAL NOT NULL,
        next_due_km INTEGER,
        FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE
      );
    ''');
  }
// ========== VEHICLES ==========
static Future<void> insertVehicle(Map<String, dynamic> data) async {
  db.execute(
    'INSERT INTO vehicles (reg_number, brand, model, capacity_kg, status) VALUES (?, ?, ?, ?, ?)',
    [data['reg_number'], data['brand'], data['model'], data['capacity_kg'], data['status']],
  );
}

static Future<void> updateVehicle(Map<String, dynamic> data, int id) async {
  db.execute(
    'UPDATE vehicles SET reg_number = ?, brand = ?, model = ?, capacity_kg = ?, status = ? WHERE id = ?',
    [data['reg_number'], data['brand'], data['model'], data['capacity_kg'], data['status'], id],
  );
}

static Future<void> deleteVehicle(int id) async {
  db.execute('DELETE FROM vehicles WHERE id = ?', [id]);
}

static List<Map<String, dynamic>> selectAllVehicles() {
  return db.select('SELECT * FROM vehicles');
}

static Map<String, dynamic>? selectVehicleById(int id) {
  final result = db.select('SELECT * FROM vehicles WHERE id = ?', [id]);
  return result.isEmpty ? null : result.first;
}

// ========== DRIVERS ==========
static Future<void> insertDriver(Map<String, dynamic> data) async {
  db.execute(
    'INSERT INTO drivers (first_name, last_name, license_number, hire_date, phone) VALUES (?, ?, ?, ?, ?)',
    [data['first_name'], data['last_name'], data['license_number'], data['hire_date'], data['phone']],
  );
}

static Future<void> updateDriver(Map<String, dynamic> data, int id) async {
  db.execute(
    'UPDATE drivers SET first_name = ?, last_name = ?, license_number = ?, hire_date = ?, phone = ? WHERE id = ?',
    [data['first_name'], data['last_name'], data['license_number'], data['hire_date'], data['phone'], id],
  );
}

static Future<void> deleteDriver(int id) async {
  db.execute('DELETE FROM drivers WHERE id = ?', [id]);
}

static List<Map<String, dynamic>> selectAllDrivers() {
  return db.select('SELECT * FROM drivers');
}

static Map<String, dynamic>? selectDriverById(int id) {
  final result = db.select('SELECT * FROM drivers WHERE id = ?', [id]);
  return result.isEmpty ? null : result.first;
}

// ========== ROUTES ==========
static Future<void> insertRoute(Map<String, dynamic> data) async {
  db.execute(
    'INSERT INTO routes (start_point, end_point, distance_km, estimated_time_min) VALUES (?, ?, ?, ?)',
    [data['start_point'], data['end_point'], data['distance_km'], data['estimated_time_min']],
  );
}

static Future<void> updateRoute(Map<String, dynamic> data, int id) async {
  db.execute(
    'UPDATE routes SET start_point = ?, end_point = ?, distance_km = ?, estimated_time_min = ? WHERE id = ?',
    [data['start_point'], data['end_point'], data['distance_km'], data['estimated_time_min'], id],
  );
}

static Future<void> deleteRoute(int id) async {
  db.execute('DELETE FROM routes WHERE id = ?', [id]);
}

static List<Map<String, dynamic>> selectAllRoutes() {
  return db.select('SELECT * FROM routes');
}

static Map<String, dynamic>? selectRouteById(int id) {
  final result = db.select('SELECT * FROM routes WHERE id = ?', [id]);
  return result.isEmpty ? null : result.first;
}

// ========== TRIPS ==========
static Future<void> insertTrip(Map<String, dynamic> data) async {
  db.execute(
    'INSERT INTO trips (vehicle_id, driver_id, route_id, departure_time, arrival_time, cargo_description, cargo_weight_kg) VALUES (?, ?, ?, ?, ?, ?, ?)',
    [
      data['vehicle_id'],
      data['driver_id'],
      data['route_id'],
      data['departure_time'],
      data['arrival_time'],
      data['cargo_description'],
      data['cargo_weight_kg'],
    ],
  );
}

static Future<void> updateTrip(Map<String, dynamic> data, int id) async {
  db.execute(
    'UPDATE trips SET vehicle_id = ?, driver_id = ?, route_id = ?, departure_time = ?, arrival_time = ?, cargo_description = ?, cargo_weight_kg = ? WHERE id = ?',
    [
      data['vehicle_id'],
      data['driver_id'],
      data['route_id'],
      data['departure_time'],
      data['arrival_time'],
      data['cargo_description'],
      data['cargo_weight_kg'],
      id,
    ],
  );
}

static Future<void> deleteTrip(int id) async {
  db.execute('DELETE FROM trips WHERE id = ?', [id]);
}

static List<Map<String, dynamic>> selectAllTrips() {
  return db.select('SELECT * FROM trips');
}

static Map<String, dynamic>? selectTripById(int id) {
  final result = db.select('SELECT * FROM trips WHERE id = ?', [id]);
  return result.isEmpty ? null : result.first;
}

// ========== MAINTENANCES ==========
static Future<void> insertMaintenance(Map<String, dynamic> data) async {
  db.execute(
    'INSERT INTO maintenances (vehicle_id, date, type, cost, next_due_km) VALUES (?, ?, ?, ?, ?)',
    [data['vehicle_id'], data['date'], data['type'], data['cost'], data['next_due_km']],
  );
}

static Future<void> updateMaintenance(Map<String, dynamic> data, int id) async {
  db.execute(
    'UPDATE maintenances SET vehicle_id = ?, date = ?, type = ?, cost = ?, next_due_km = ? WHERE id = ?',
    [data['vehicle_id'], data['date'], data['type'], data['cost'], data['next_due_km'], id],
  );
}

static Future<void> deleteMaintenance(int id) async {
  db.execute('DELETE FROM maintenances WHERE id = ?', [id]);
}

static List<Map<String, dynamic>> selectAllMaintenances() {
  return db.select('SELECT * FROM maintenances');
}

static Map<String, dynamic>? selectMaintenanceById(int id) {
  final result = db.select('SELECT * FROM maintenances WHERE id = ?', [id]);
  return result.isEmpty ? null : result.first;
}
  static void close() {
    _db?.dispose();
    _db = null;
  }
}