import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid.toString();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              semanticLabel: 'exit',
            ),
            onPressed: () {
              signOut();
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children:  [
            Image.network(
              'http://handong.edu/site/handong/res/img/logo.png',
              color: Colors.white,
            ),
            const Padding(padding: EdgeInsets.all(50)),
            Text(
              uid!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            const SizedBox(
              width: 400,
              child: Divider(
                  color: Colors.white,
                  thickness: 1.0
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            const Text(
              "Anonymous",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  
}

