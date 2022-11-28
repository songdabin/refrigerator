import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:shrine/list.dart';
import 'package:shrine/recipe.dart';

import 'home.dart';
import 'login.dart';
import 'profile.dart';
import 'list.dart';
import 'add.dart';
import 'scan.dart';
import 'recipe.dart';

class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        '/profile': (BuildContext context) => const ProfilePage(),
        '/list': (BuildContext context) => const ListPage(),
        '/add': (BuildContext context) => const ProductAddPage(),
        '/scan': (BuildContext context) => const ScanPage(),
        '/recipe': (BuildContext context) => const RecipePage(),
        // '/detail': (BuildContext context) => const DetailPage(),
      },
    );
  }
}
