import 'package:flutter/cupertino.dart';
import 'package:flutter_design_pattern/repository/address_repository.dart';
import 'package:flutter_design_pattern/util/event.dart';
import 'dart:async';

class SearchViewModel extends ChangeNotifier {
  String _zipcode = '';
  String get zipcode => _zipcode;
  set zipcode(String s) {
    _zipcode = s.replaceAll('_', '');
  }

  String _address = '';
  String get address => _address;

  final _searchSuccessAction = StreamController<Event>();
  StreamController<Event> get searchSuccessAction => _searchSuccessAction;

  Future search() async {
    if (_zipcode.isEmpty) {
      return;
    }

    var address = await AddressRepository().fetchAddressRepository(_zipcode);
    debugPrint(address.address);
    _address = address.address;

    notifyListeners();
    _searchSuccessAction.sink.add(Event());
  }

  @override
  void dispose() {
    _searchSuccessAction.close();

    super.dispose();
  }
}