import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrine/edit.dart';
import 'ApplicationState.dart';

import 'model/product.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage({Key? key, required this.product}) : super(key: key);

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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(product: product)));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      semanticLabel: 'delete',
                    ),
                    onPressed: () {
                      appState.deleteProduct(product.docid);
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
            product.image,
            width: 400,
          ),
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("NAME",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              Container(width: 20,),
              Text(product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("DETAIL",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              Container(width: 20,),
              Text(product.detail,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: CupertinoColors.inactiveGray,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             semanticLabel: 'back',
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('Detail'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.create,
//               semanticLabel: 'create',
//             ),
//             onPressed: () {
//               print("add");
//             },
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.delete,
//               semanticLabel: 'delete',
//             ),
//             onPressed: () {
//               print("delete");
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: const [
//           Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
//           Text(name),
//         ],
//       ),
//       resizeToAvoidBottomInset: false,
//     );
//   }
// }