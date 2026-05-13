bool isValidRequiredString(String? input) {
  return input != null && input.trim().isNotEmpty;
}

bool isValidPositiveInt(int value) => value > 0;
bool isValidPositiveDouble(double value) => value > 0.0;

bool isValidDateTime(String input) {
  return DateTime.tryParse(input) != null;
}