import 'package:flutter/material.dart';
import 'package:flutter_design_pattern/search_actions.dart';
import 'package:flutter_design_pattern/app_state.dart';
import 'package:flutter_design_pattern/middleware.dart';
import 'package:flutter_design_pattern/reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  final Store<AppState> store = Store(reducer, initialState: const AppState('', ''), middleware: [middleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _SearchPageBody(),
      ),
    );
  }
}

class _SearchPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageBodyState();
  }
}

class _SearchPageBodyState extends State<_SearchPageBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _ZipcodeTextField(),
            SizedBox(
                width: double.infinity,
                child: _SearchButton()
            ),
            _AddressText()
          ],
        ),
      ),
    );
  }
}

class _ZipcodeTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        distinct: true,
        converter: (Store<AppState> store) => store.state.zipcode,
        builder: (context, zipcode) =>
            TextField(
              onChanged: (text) {
                debugPrint(text);
                zipcode = text;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '郵便番号を入力してください',
                hintText: '0000000',
                enabled: true,
              ),
            )
    );
  }
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
        distinct: true,
        converter: (Store<AppState> store) => store.dispatch(SearchAddressAction()),
        builder: (context, callback) {
          return ElevatedButton(
              onPressed: () => { callback },
              child: const Text(
                  '住所検索'
              )
          );
        }
    );
  }
}

class _AddressText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        distinct: true,
        converter: (Store<AppState> store) => store.state.address,
        builder: (context, address) {
          return Text(
            '$address',
            style: Theme.of(context).textTheme.bodyText1,
          );
        }
    );
  }
}