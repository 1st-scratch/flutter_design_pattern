import 'package:flutter/material.dart';
import 'package:flutter_design_pattern/view_model/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
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

    var viewModel = Provider.of<SearchViewModel>(context, listen: false);
    viewModel.searchSuccessAction.stream.listen((_) {
      debugPrint('success!!');
    });
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
    return Consumer<SearchViewModel>(
        builder: (context, viewModel, _) {
          return TextField(
            onChanged: (text) {
              debugPrint(text);
              viewModel.zipcode = text;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '郵便番号を入力してください',
              hintText: '0000000',
              enabled: true,
            ),
          );
        }
    );
  }
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
        builder: (context, viewModel, _) {
          return ElevatedButton(
              onPressed: (){ viewModel.search(); },
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
    return Consumer<SearchViewModel>(
        builder: (context, viewModel, _) {
          return Text(
            viewModel.address,
            style: Theme.of(context).textTheme.bodyText1,
          );
        }
    );
  }
}