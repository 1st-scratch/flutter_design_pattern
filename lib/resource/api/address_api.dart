import 'package:http/http.dart' as http;

class AddressApiProvider {
  fetchAddressApi(String url) async {
    return await http.get(Uri.parse(url));
  }
}