import 'package:flutter/cupertino.dart';
import 'package:flutter_design_pattern/util/event.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

    var url = Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$_zipcode&limit=1');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var result = data['results'][0];
    var address1 = result['address1'];
    var address2 = result['address2'];
    var address3 = result['address3'];
    debugPrint(response.body);
    _address = '$address1$address2$address3';

    notifyListeners();
    _searchSuccessAction.sink.add(Event());
  }

  @override
  void dispose() {
    _searchSuccessAction.close();

    super.dispose();
  }
}