import 'package:floor_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'db/database.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const HomePage(),
    );
  }
}
