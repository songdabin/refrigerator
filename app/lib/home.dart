import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart'
  hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shrine/ApplicationState.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.person,
        //     semanticLabel: 'profile',
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/profile');
        //   },
        // ),
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
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  Column(
                    children:  [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                        child: const ListTile(
                          title: Text("당근"),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                        child: const ListTile(
                          title: Text("당근"),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                        child: const ListTile(
                          title: Text("당근"),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                        child: const ListTile(
                          title: Text("당근"),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ],
            ),
          ),
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
              title: const Text('바코드 스캔'),
              onTap: () {
                Navigator.pop(context);
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
                Navigator.pop(context);
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