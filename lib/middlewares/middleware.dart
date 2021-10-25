import 'package:flutter_design_pattern/repository/address_repository.dart';
import 'package:flutter_design_pattern/resource/models/address_model.dart';
import 'package:flutter_design_pattern/actions/search_actions.dart';
import 'package:flutter_design_pattern/app_state.dart';
import 'package:redux/redux.dart';

void middleware(Store<AppState> store, action, NextDispatcher next) async {
  if(action is SearchAddressAction ) {
    if (store.state.zipcode.isEmpty) {
      return;
    }

    await AddressRepository().fetchAddressRepository(store.state.zipcode).then((Address address) {
      next(SearchAddressSucceededAction(address.address));
    }).catchError((Exception error) {
      // Do something
    }).whenComplete(()=> {
      // Do something
    });
  }
  next(action);
}