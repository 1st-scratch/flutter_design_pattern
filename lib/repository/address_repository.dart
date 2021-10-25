import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_design_pattern/resource/api/address_api.dart';
import 'package:flutter_design_pattern/resource/models/address_model.dart';

class AddressRepository {
  fetchAddressRepository(String zipcode) async {
    final String url = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipcode';
    final response = await AddressApiProvider().fetchAddressApi(url);

    if (response.statusCode == 200) {
      debugPrint(response.body);
      final decoded = await json.decode(response.body);
      return Address.fromJson(decoded);
    } else {
      throw Exception('Error');
    }
  }
}