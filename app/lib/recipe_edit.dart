import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrine/model/recipe.dart';
import 'ApplicationState.dart';


class RecipeEditPage extends StatelessWidget {
  final Recipe recipe;
  RecipeEditPage({Key? key, required this.recipe}) : super(key: key);
  final _formKey = GlobalKey<FormState>(debugLabel: '_EditPageState');
  final _nameController = TextEditingController();
  final _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = recipe.name;
    _detailController.text = recipe.detail;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.inactiveGray,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Edit'),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  TextButton(
                    onPressed: () {
                      appState.deleteRecipe(recipe.docid);
                      appState.addRecipe(_nameController.text, _detailController.text);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                          children: [
                            Container(
                              child: Image.network(
                                recipe.image,
                                width: 400,
                              ),
                              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                hintText: 'item name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter item name to continue';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _detailController,
                              decoration: const InputDecoration(
                                hintText: 'item detail',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter item detail to continue';
                                }
                                return null;
                              },
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ]
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}


