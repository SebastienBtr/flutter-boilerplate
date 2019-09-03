import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/blocs/password_forgot/passwordForgotBloc.dart';
import 'package:flutter_boilerplate/screens/password_forgot/widgets/passwordForgotForm.dart';
import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter/material.dart';

class PasswordForgotPage extends StatefulWidget {
  @override
  _PasswordForgotPageState createState() => _PasswordForgotPageState();
}

class _PasswordForgotPageState extends State<PasswordForgotPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    passwordForgotBloc = PasswordForgotBloc();
    mainBloc.currentScaffoldKey = scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(Translations.of(context).text('password forgot')),
      ),
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
            child: passwordForgotBloc.isLoading
                ? const CircularProgressIndicator()
                : ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset('assets/logo.png', height: 120,),
                        ),
                        Card(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    '${passwordForgotBloc.errorMessage}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                PasswordForgotForm(
                                  onSubmit: (String email) => passwordForgotBloc
                                      .requestPassword(context, this, email),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
