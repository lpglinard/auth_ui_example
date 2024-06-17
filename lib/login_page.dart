import 'package:auth_example/auth_service_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({super.key, required this.title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: LoginView(
        action: AuthAction.signIn,
        providers: FirebaseUIAuth.providersFor(
          FirebaseAuth.instance.app,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String email = "olucaslinard@gmail.com";
          String  password = "laçlfkasdhapdgasf";
          try {
            await Provider.of<AuthService>(context, listen: false)
                .registerWithEmailAndPassword(email, password);
          } on Exception {
            await Provider.of<AuthService>(context, listen: false)
                .signInWithEmailAndPassword(email, password);          }

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
