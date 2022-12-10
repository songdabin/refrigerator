import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ApplicationState.dart';

import 'model/product.dart';

class EditPage extends StatelessWidget {
  final Product product;
  EditPage({Key? key, required this.product}) : super(key: key);
  final _formKey = GlobalKey<FormState>(debugLabel: '_EditPageState');
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = product.name;
    _detailController.text = product.detail;

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
        title: const Text('Edit'),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  TextButton(
                    onPressed: () {
                      appState.editProduct(product.docid, _nameController.text, _detailController.text, product.image);
                      // appState.deleteProduct(product.docid);
                      // appState.addProductToProducts(_nameController.text, _detailController.text, url);
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
                                product.image,
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


