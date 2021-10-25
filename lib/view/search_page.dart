import 'package:flutter/material.dart';
import 'package:flutter_design_pattern/bloc/search_bloc.dart';
import 'package:flutter_design_pattern/util/event.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SearchBloc>(
          create: (context) => SearchBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        ),
      ],
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
    final searchBloc = Provider.of<SearchBloc>(context);
    return TextField(
      onChanged: (text) {
        debugPrint(text);
        searchBloc.zipcode = text;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '郵便番号を入力してください',
        hintText: '0000000',
        enabled: true,
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    return ElevatedButton(
        onPressed: (){ searchBloc.searchAction.add(Event()); },
        child: const Text(
            '住所検索'
        )
    );
  }
}

class _AddressText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    return StreamBuilder(
      initialData: '',
      stream: searchBloc.searchResult,
      builder: (context, snapshot) {
        return Text(
          searchBloc.address,
          style: Theme
              .of(context)
              .textTheme
              .bodyText1,
        );
      }
    );
  }
}