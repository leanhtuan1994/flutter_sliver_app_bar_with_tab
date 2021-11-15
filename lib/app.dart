import 'package:flutter/material.dart';
import 'screens/main_tab_bar.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainTabBar(),
    );
  }
}
