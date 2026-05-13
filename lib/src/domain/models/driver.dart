class Driver {
  int? id;
  String firstName;
  String lastName;
  String licenseNumber;
  DateTime hireDate;
  String phone;

  Driver({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.licenseNumber,
    required this.hireDate,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'license_number': licenseNumber,
    'hire_date': hireDate.toIso8601String(),
    'phone': phone,
  };

  factory Driver.fromMap(Map<String, dynamic> map) => Driver(
    id: map['id'],
    firstName: map['first_name'],
    lastName: map['last_name'],
    licenseNumber: map['license_number'],
    hireDate: DateTime.parse(map['hire_date']),
    phone: map['phone'],
  );

  @override
  String toString() => '[$id] $firstName $lastName | права: $licenseNumber | тел: $phone';
}