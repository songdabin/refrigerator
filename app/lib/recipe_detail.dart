import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrine/edit.dart';
import 'package:shrine/model/recipe.dart';
import 'package:shrine/recipe_edit.dart';
import 'ApplicationState.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Detail'),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  IconButton(
                    icon: const Icon(
                      Icons.create,
                      semanticLabel: 'edit',
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeEditPage(recipe: recipe)));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      semanticLabel: 'delete',
                    ),
                    onPressed: () {
                      appState.deleteRecipe(recipe.docid);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.network(
              recipe.imageurl,
              width: 400,
            ),
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
          ),
          const Text("NAME",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),

          Text(recipe.name,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
            ),
          ),

          const SizedBox(height: 30,),
          const Text("DETAIL",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),

          Expanded(child: Text(recipe.detail,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
            ),
          )
          ),

          const SizedBox(height: 30,),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}