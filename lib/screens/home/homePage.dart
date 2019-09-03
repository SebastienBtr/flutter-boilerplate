import 'package:flutter_boilerplate/blocs/authBloc.dart';
import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    mainBloc.currentScaffoldKey = scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text(
            Translations.of(context).text('Logout').toUpperCase(),
          ),
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
          onPressed: () {
            authBloc.logout(context, this);
          },
        ),
      ),
    );
  }
}
