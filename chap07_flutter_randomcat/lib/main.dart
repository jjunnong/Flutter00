import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FavoritePage.dart';
import 'HomePage.dart';
import 'CatService.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/favorite': (context) => FavoritePage(),
      },
    );
  }
}
