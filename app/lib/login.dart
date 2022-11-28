import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 240.0),
            Column(
              children: const <Widget>[
                Text('냉장고',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            Column(
              // alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text(''),
                  onPressed: () {
                    // _usernameController.clear();
                    // _passwordController.clear();
                    signInWithGoogle();
                  },
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                  ),
                  child: const Text('Guest'),
                  onPressed: () {
                    signInAnon();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void signInAnon() async {
  try {
    final userCredential =
    await FirebaseAuth.instance.signInAnonymously();
    // print(userCredential);
    print("Signed in with temporary account.");
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        print("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        print("Unknown error.");
    }
  }
}

Future signOut() async {
  try {
    print('sign out complete');
    return await FirebaseAuth.instance.signOut();
  } catch (e) {
    print('sign out failed');
    print(e.toString());
    return null;
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}