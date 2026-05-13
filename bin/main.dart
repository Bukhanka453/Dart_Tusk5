import 'package:autopark_cli/mmm.dart';

void main() {
  final menu = Menu();
  menu.run();
  DatabaseHelper.close();
}