import 'package:flutter/material.dart';
import 'package:myproject/src/core/utils/injections.dart';
import 'package:myproject/src/features/court/presentation/pages/court_page.dart';

Future<void> main() async {
  await initInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CourtPage(),
    );
  }
}
