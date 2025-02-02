import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:expense_tracker/data/expense.data.dart';
import 'package:expense_tracker/pages/home.page.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox('expenses_db');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          fontFamily: 'Satoshi',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
