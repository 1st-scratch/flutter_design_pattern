import 'package:meta/meta.dart';

@immutable
class AppState {
  final String zipcode;
  final String address;
  const AppState(this.zipcode, this.address);
}