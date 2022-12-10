import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart'
  hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shrine/ApplicationState.dart';
import 'package:shrine/detail.dart';
import 'package:shrine/model/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              semanticLabel: 'add',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  SizedBox(
                    height: 770,
                    child: ProductList(
                      addProduct: (name, price, detail, url) =>
                          appState.addProductToProducts(name, detail, url),
                      products: appState.products,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          // Consumer<ApplicationState>(
          //   builder: (context, appState, _) => Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       if (appState.loggedIn) ...[
          //         Column(
          //           children:  [
          //             Container(
          //               margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          //               padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
          //               child: const ListTile(
          //                 title: Text("당근"),
          //               ),
          //               decoration: BoxDecoration(
          //                 border: Border.all(
          //                   width: 1,
          //                   color: CupertinoColors.inactiveGray,
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          //               padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
          //               child: const ListTile(
          //                 title: Text("당근"),
          //               ),
          //               decoration: BoxDecoration(
          //                 border: Border.all(
          //                   width: 1,
          //                   color: CupertinoColors.inactiveGray,
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          //               padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
          //               child: const ListTile(
          //                 title: Text("당근"),
          //               ),
          //               decoration: BoxDecoration(
          //                 border: Border.all(
          //                   width: 1,
          //                   color: CupertinoColors.inactiveGray,
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          //               padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
          //               child: const ListTile(
          //                 title: Text("당근"),
          //               ),
          //               decoration: BoxDecoration(
          //                 border: Border.all(
          //                   width: 1,
          //                   color: CupertinoColors.inactiveGray,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         )
          //       ],
          //     ],
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            ListTile(
              title: const Text('이미지 스캔'),
              onTap: () {
                Navigator.pushNamed(context, '/scan');
              },
            ),
            ListTile(
              title: const Text('냉장고 보기'),
              onTap: () {
                Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              title: const Text('레시피 보기'),
              onTap: () {
                Navigator.pushNamed(context, '/recipe');
              },
            ),
            ListTile(
              title: const Text('프로필'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class ProductList extends StatefulWidget {
  const  ProductList({Key? key,
    // super.key,
    required this.products, required this.addProduct,
  }) : super(key: key);

  final FutureOr<void> Function(String name, int price, String detail, String url) addProduct;
  final List<Product> products;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        for (var product in widget.products)
          Card(
            child: Column(
              children: [
                Image.network(
                  product.image,
                  width: 150,
                  height: 100,
                ),
                Text(product.name),
                // Text(product.price.toString()),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(product: product)));
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
