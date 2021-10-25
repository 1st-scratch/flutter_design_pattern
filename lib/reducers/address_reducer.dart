import 'package:flutter_design_pattern/actions/search_actions.dart';
import 'package:redux/redux.dart';

final addressReducer = combineReducers<String>([
  TypedReducer<String, SearchAddressSucceededAction>(_setAddress),
]);

String _setAddress(String address, SearchAddressSucceededAction action){
  return action.address;
}