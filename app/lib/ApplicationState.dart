import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
  hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:shrine/firebase_options.dart';

import 'model/product.dart';
import 'model/recipe.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _productSubscription;
  StreamSubscription<QuerySnapshot>? _recipeSubscription;
  List<Product> _products = [];
  List<Recipe> _recipes = [];
  List<Product> get products => _products;
  List<Recipe> get recipes => _recipes;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    
    FirebaseAuth.instance.userChanges().listen((user) { 
      if (user != null) {
        _loggedIn = true;
        _productSubscription = FirebaseFirestore.instance
          .collection('item')
          .orderBy('price', descending: true)
          .snapshots()
          .listen((snapshot) {
            _products = [];
            for (final doc in snapshot.docs) {
              _products.add(
                Product(
                  detail: doc.data()['detail'] as String,
                  name: doc.data()['name'] as String,
                  image: doc.data()['image'] as String,
                  docid: doc.id,
                ),
              );
            }
            notifyListeners();
        });
        _recipeSubscription = FirebaseFirestore.instance
            .collection('recipe')
            // .orderBy('price', descending: true)
            .snapshots()
            .listen((snapshot) {
          _recipes = [];
          for (final doc in snapshot.docs) {
            _recipes.add(
              Recipe(
                detail: doc.data()['detail'] as String,
                name: doc.data()['name'] as String,
                image: doc.data()['image'] as String,
                docid: doc.id,
              ),
            );
          }
          notifyListeners();
        });
      }
      else {
        _loggedIn = false;
        _products = [];
        _recipes = [];
        _productSubscription?.cancel();
        _recipeSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addProductToProducts(String name, String detail) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }
    return FirebaseFirestore.instance
        .collection('item')
        .add(<String, dynamic>{
      // 'id': id,
      'name': name,
      'image': 'https://handong.edu/site/handong/res/img/logo.png',
      'detail': detail,
    });
  }

  Future<DocumentReference> editProduct(String docid, String name, String detail) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }
    FirebaseFirestore.instance.collection("item").doc(docid).delete();
    return FirebaseFirestore.instance
        .collection('item')
        .add(<String, dynamic>{
      // 'id': id,
      'name': name,
      'image': 'https://handong.edu/site/handong/res/img/logo.png',
      'detail': detail,
    });
  }

  void deleteProduct(String docid) {
    FirebaseFirestore.instance.collection("item").doc(docid).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  // recipe
  Future<DocumentReference> addRecipe(String name, String detail) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }
    return FirebaseFirestore.instance
        .collection('recipe')
        .add(<String, dynamic>{
      // 'id': id,
      'name': name,
      'image': 'https://handong.edu/site/handong/res/img/logo.png',
      'detail': detail,
    });
  }

  Future<DocumentReference> editRecipe(String docid, String name, String detail) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }
    FirebaseFirestore.instance.collection("recipe").doc(docid).delete();
    return FirebaseFirestore.instance
        .collection('item')
        .add(<String, dynamic>{
      // 'id': id,
      'name': name,
      'image': 'https://handong.edu/site/handong/res/img/logo.png',
      'detail': detail,
    });
  }

  void deleteRecipe(String docid) {
    FirebaseFirestore.instance.collection("recipe").doc(docid).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }
}