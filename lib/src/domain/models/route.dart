class Route {
  int? id;
  String startPoint;
  String endPoint;
  double distanceKm;
  int estimatedTimeMin;

  Route({
    this.id,
    required this.startPoint,
    required this.endPoint,
    required this.distanceKm,
    required this.estimatedTimeMin,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'start_point': startPoint,
    'end_point': endPoint,
    'distance_km': distanceKm,
    'estimated_time_min': estimatedTimeMin,
  };

  factory Route.fromMap(Map<String, dynamic> map) => Route(
    id: map['id'],
    startPoint: map['start_point'],
    endPoint: map['end_point'],
    distanceKm: map['distance_km'],
    estimatedTimeMin: map['estimated_time_min'],
  );

  @override
  String toString() => '[$id] $startPoint → $endPoint | ${distanceKm}км | ~${estimatedTimeMin}мин';
}