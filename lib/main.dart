import 'package:flutter/material.dart';
import 'package:test_login/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // flutter pub add flutter_localization:0.1.13
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('ja')],
      title: 'Flutter Demo',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
