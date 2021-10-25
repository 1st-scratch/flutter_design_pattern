import 'package:flutter_design_pattern/actions/search_actions.dart';
import 'package:flutter_design_pattern/app_state.dart';

AppState reducer(AppState state, action) {
  if (action is SearchAddressAction) {
    return AppState(
        state.zipcode,
        state.address
    );
  }
  return state;
}