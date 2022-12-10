import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shrine/ApplicationState.dart';
import 'package:shrine/recipe_detail.dart';

import 'model/product.dart';
import 'model/recipe.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text('레시피'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              semanticLabel: 'add',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/recipe_add');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  SizedBox(
                    height: 770,
                    child: RecipeList(
                      addRecipe: (name, detail, url) =>
                          appState.addRecipe(name, detail, url),
                      recipes: appState.recipes,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class RecipeList extends StatefulWidget {
  const  RecipeList({Key? key,
    // super.key,
    required this.addRecipe,
    required this.recipes,
  }) : super(key: key);

  final FutureOr<void> Function(String name, String detail, String url) addRecipe;
  final List<Recipe> recipes;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        for (var recipe in widget.recipes)
          Card(
            child: Column(
              children: [
                Image.network(
                  recipe.imageurl,
                  width: 150,
                  height: 100,
                ),
                Text(recipe.name),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)));
                    },
                    child: const Text("more")
                ),
              ],
            ),
          ),
      ],
    );
  }
}