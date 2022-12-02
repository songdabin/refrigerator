import 'dart:async';
import 'dart:io';

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
import 'package:shrine/model/recipe.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecipeAddPage extends StatelessWidget {
  const RecipeAddPage({Key? key}) : super(key: key);
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
        title: const Text('레시피 추가'),
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
                    height: 200,
                    child: RecipeAdd(
                      addRecipe: (name, detail) =>
                          appState.addProductToProducts(name, detail),
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

class RecipeAdd extends StatefulWidget {
  const RecipeAdd({Key? key,
    required this.addRecipe,
    required this.recipes,
  }) : super(key: key);

  final FutureOr<void> Function(String name, String detail) addRecipe;
  final List<Recipe> recipes;

  @override
  State<RecipeAdd> createState() => _RecipeAddState();
}

class _RecipeAddState extends State<RecipeAdd> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_AddPageState');
  final _nameController = TextEditingController();
  final _detailController = TextEditingController();

  File? _image;

  Future uploadFile(String filename1) async {
    if (_image == null) return;
    final fileName = filename1;
    final destination = '$fileName.jpg';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination);
      await ref.putFile(_image!);
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      IconButton(
                        onPressed: getImageFromGallery,
                        icon: const Icon(Icons.image),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await widget.addRecipe(_nameController.text,
                                 _detailController.text);
                            _nameController.clear();
                            _detailController.clear();
                          }
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.send, color: Colors.black,),
                            SizedBox(width: 4),
                            Text('Save', style: TextStyle(color: Colors.black),),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ]
    );
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
