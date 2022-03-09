import 'package:flutter/material.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/ui/components/app_theme.dart';
import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      home: LoginPage(),
    );
  }
}
