import 'package:flutter_design_pattern/app_state.dart';
import 'search_actions.dart';

AppState reducer(AppState state, action) {
  if (action is SearchAddressAction) {
    return AppState(
        state.zipcode,
        state.address
    );
  }
  return state;
}