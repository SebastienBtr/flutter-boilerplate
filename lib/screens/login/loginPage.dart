import 'package:flutter_boilerplate/blocs/authBloc.dart';
import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/screens/login/widgets/loginForm.dart';
import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: authBloc.isLoading
                  ?
                  // Loading indicator
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            Translations.of(context).text('Login...'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  :
                  // Login form
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              'assets/logo.png',
                              height: 120,
                            ),
                          ),
                          Card(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    '${authBloc.loginError}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                LoginForm(
                                  onSubmit: (String login, String password) =>
                                      authBloc.login(
                                          context, this, login, password),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
