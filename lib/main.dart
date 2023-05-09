import 'package:challenge/provider/exhibits_loader.dart';
import 'package:challenge/screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ExhibitsLoader(),
        builder: (context, child) {
          return const UserScreen();
        },
      ),
    );
  }
}
