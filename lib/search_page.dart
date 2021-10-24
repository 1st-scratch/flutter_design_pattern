import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _zipcode = '';
  String _address = '';

  Future _search() async {
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
    setState((){
      _address = '$address1$address2$address3';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  debugPrint(text);
                  setState((){
                    _zipcode = text.replaceAll('-', '');
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '郵便番号を入力してください',
                  hintText: '0000000',
                  enabled: true,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _search,
                  child: const Text(
                    '住所検索'
                  ),
                ),
              ),
              Text(
                _address,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
