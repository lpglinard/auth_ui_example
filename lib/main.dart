import 'package:auth_example/auth_service_provider.dart';
import 'package:auth_example/firebase_options.dart';
import 'package:auth_example/login_page.dart';
import 'package:auth_example/my_home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ui.FirebaseUIAuth.configureProviders(<ui.AuthProvider>[
    ui.EmailAuthProvider(),
    GoogleProvider(clientId: "679878325995-fmifib4hmn9aecspsq7i5daa3r3qs7ns.apps.googleusercontent.com"),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorObservers: <NavigatorObserver>[MyApp.observer],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return authService.isAuthenticated ? NewsScreen(title: "Usuário Logado") :
    LoginPage(title: "Tela de login");
  }
}
