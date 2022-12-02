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
import 'package:shrine/detail.dart';

import 'model/product.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);
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
        title: const Text('이미지 스캔'),
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
                    child: Add(
                      addProduct: (name, price, detail) =>
                          appState.addProductToProducts(name, detail),
                      products: appState.products,
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

class Add extends StatefulWidget {
  const Add({Key? key,
    required this.addProduct,
    required this.products,
  }) : super(key: key);

  final FutureOr<void> Function(String name, int price, String detail) addProduct;
  final List<Product> products;

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_AddPageState');
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailController = TextEditingController();

  PickedFile? _image;

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
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            decoration: const InputDecoration(
                              hintText: 'item price',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter item price to continue';
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
                            await widget.addProduct(_nameController.text,
                                int.parse(_priceController.text), _detailController.text);
                            _nameController.clear();
                            _priceController.clear();
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
      _image = image!;
    });
  }
}
