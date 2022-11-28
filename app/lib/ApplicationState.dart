import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
  hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:shrine/firebase_options.dart';

import 'model/product.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _productSubscription;
  List<Product> _products = [];
  List<Product> get products => _products;

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
                  price: doc.data()['price'] as int,
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
        _productSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addProductToProducts(String name, int price, String detail) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }
    return FirebaseFirestore.instance
        .collection('item')
        .add(<String, dynamic>{
      // 'id': id,
      'name': name,
      'image': 'https://handong.edu/site/handong/res/img/logo.png',
      'price': price,
      'detail': detail,
    });
  }

  Future<DocumentReference> editProduct(String docid, String name, int price, String detail) {
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
      'price': price,
      'detail': detail,
    });
  }

  void deleteProduct(String docid) {
    FirebaseFirestore.instance.collection("item").doc(docid).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }
}