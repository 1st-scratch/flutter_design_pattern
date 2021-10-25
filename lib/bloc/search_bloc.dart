import 'package:flutter/cupertino.dart';
import 'package:flutter_design_pattern/repository/address_repository.dart';
import 'package:flutter_design_pattern/util/event.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  String _zipcode = '';
  String get zipcode => _zipcode;
  set zipcode(String s) {
    _zipcode = s.replaceAll('_', '');
  }

  String _address = '';
  String get address => _address;

  final _searchAction = BehaviorSubject<void>();
  Sink<void> get searchAction => _searchAction.sink;

  final _searchResultController = BehaviorSubject<String>();
  Stream<String> get searchResult => _searchResultController.stream;

  SearchBloc() {
    _searchAction.stream.listen((_) async {
      if (_zipcode.isEmpty) {
        return;
      }

      var address = await AddressRepository().fetchAddressRepository(_zipcode);
      debugPrint(address.address);
      _address = address.address;

      _searchResultController.sink.add(address.address);
    });
  }

  void dispose() {
    _searchResultController.close();
  }
}