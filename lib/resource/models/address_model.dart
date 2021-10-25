class Address {
  String address1;
  String address2;
  String address3;
  String get address => '$address1$address2$address3';

  Address({required this.address1, required this.address2, required this.address3});

  factory Address.fromJson(Map<String, dynamic> json) {
    var result = json['results'][0];
    return Address(
      address1: result['address1'],
      address2: result['address2'],
      address3: result['address3']
    );
  }
}